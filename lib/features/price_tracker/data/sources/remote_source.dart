import 'dart:convert';

import 'package:deriv/core/api/endpoints.dart';
import 'package:deriv/features/price_tracker/data/models/active_symbol_model.dart';
import 'package:deriv/features/price_tracker/data/models/tick_model.dart';
import 'package:deriv/features/price_tracker/domain/entity/active_symbol.dart';
import 'package:deriv/features/price_tracker/domain/entity/tick.dart';
import 'package:web_socket_channel/io.dart';

abstract class SymbolsRemoteSource {
  Stream<List<ActiveSymbol>> streamActiveSymbols();
  Stream<Tick> streamPrice(Tick? oldTick, String symbol);
}

class AppSymbolsRemoteSource implements SymbolsRemoteSource {
  IOWebSocketChannel channel;
  bool isClosed = true;

  AppSymbolsRemoteSource()
      : channel = IOWebSocketChannel.connect(Endpoint.derivSocketEndpoint);

  @override
  Stream<List<ActiveSymbolModel>> streamActiveSymbols() async* {
    // if (channel.innerWebSocket == null) {
    //   channel = IOWebSocketChannel.connect(Endpoint.derivSocketEndpoint);
    // }
    final query =
        json.encode({"active_symbols": "brief", "product_type": "basic"});
    channel.sink.add(query);
    // Stream.periodic(const Duration(seconds: 20), (_) {
    //   channel.sink.add(query);
    // });

    yield* channel.stream.map((event) {
      print(event);
      final data = json.decode(event);
      final List activeSymbols = data["active_symbols"];

      return activeSymbols.map((e) => ActiveSymbolModel.fromJson(e)).toList();
    });
    channel.sink.close().then((value) {
      isClosed = true;
      print('channel closed');
    });
  }

  @override
  Stream<TickModel> streamPrice(Tick? oldTick, String symbol) async* {
    if (isClosed) {
      channel = IOWebSocketChannel.connect(Endpoint.derivSocketEndpoint);
      print('channeld is connected');
      isClosed = false;
    }

    if (oldTick != null) {
      print('end price stream for ${oldTick.symbol}');
      print(oldTick.id);
      final forgetQuery = json.encode({"forget": oldTick.id});

      channel.sink.add(forgetQuery);
    }

    final query = json.encode({"ticks": symbol});

    channel.sink.add(query);

    yield* channel.stream.map((event) {
      final data = json.decode(event);
      // print(data['tick']['symbol']);

      final tick = data["tick"];

      return TickModel.fromJson(tick);
    });
  }
}
