import 'dart:convert';

import 'package:deriv/core/api/endpoints.dart';
import 'package:deriv/features/price_tracker/data/models/active_symbol_model.dart';
import 'package:deriv/features/price_tracker/data/models/tick_model.dart';
import 'package:deriv/features/price_tracker/domain/entity/active_symbol.dart';
import 'package:deriv/features/price_tracker/domain/entity/tick.dart';
import 'package:web_socket_channel/io.dart';

abstract class SymbolsRemoteSource {
  Stream<List<ActiveSymbol>> streamActiveSymbols();
  Stream<Tick> streamPrice(String symbol);
  Stream<void> endPriceStream(Tick tick);
}

class AppSymbolsRemoteSource implements SymbolsRemoteSource {
  @override
  Stream<List<ActiveSymbolModel>> streamActiveSymbols() async* {
    const url = Endpoint.derivSocketEndpoint;

    final channel = IOWebSocketChannel.connect(url);

    final query =
        json.encode({"active_symbols": "brief", "product_type": "basic"});
    channel.sink.add(query);
    Stream.periodic(const Duration(seconds: 20), (_) {
      channel.sink.add(query);
    });

    yield* channel.stream.map((event) {
      final data = json.decode(event);
      final List activeSymbols = data["active_symbols"];

      return activeSymbols.map((e) => ActiveSymbolModel.fromJson(e)).toList();
    });
  }

  @override
  Stream<TickModel> streamPrice(String symbol) async* {
    const url = Endpoint.derivSocketEndpoint;

    final channel = IOWebSocketChannel.connect(url);

    final query = json.encode({"ticks": symbol});

    channel.sink.add(query);

    yield* channel.stream.map((event) {
      final data = json.decode(event);
      print(data['tick']['symbol']);
      print(runtimeType.hashCode);

      //Forget noisy old streams.
      if (data["echo_req"]["ticks"] != symbol) {
        print('removing query');
        final forgetQuery = json.encode({"forget": data["tick"]["id"]});

        channel.sink.add(forgetQuery);
      }

      final tick = data["tick"];

      return TickModel.fromJson(tick);
    });
  }

  @override
  Stream<void> endPriceStream(Tick tick) async* {
    const url = Endpoint.derivSocketEndpoint;

    final channel = IOWebSocketChannel.connect(url);

    channel.stream.listen(
      (event) {
        final forgetQuery = json.encode({"forget": tick.id});

        channel.sink.add(forgetQuery);
      },
    );
  }
}
