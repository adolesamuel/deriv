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
      : channel = IOWebSocketChannel.connect(Endpoint.derivSocketEndpoint),
        isClosed = false;

  void _connectSocket() {
    channel = IOWebSocketChannel.connect(Endpoint.derivSocketEndpoint);
    isClosed = false;
  }

  void _closeSocket() {
    channel.sink.close().then((value) {
      isClosed = true;
    });
  }

  @override
  Stream<List<ActiveSymbolModel>> streamActiveSymbols() async* {
    final query =
        json.encode({"active_symbols": "brief", "product_type": "basic"});
    channel.sink.add(query);

    yield* channel.stream.map((event) {
      final data = json.decode(event);
      final List activeSymbols = data["active_symbols"];
      _closeSocket();

      return activeSymbols.map((e) => ActiveSymbolModel.fromJson(e)).toList();
    });
  }

  @override
  Stream<TickModel> streamPrice(Tick? oldTick, String symbol) async* {
    if (isClosed) {
      _connectSocket();
    }

    //Remove Noisy ticks
    if (oldTick != null) {
      final forgetQuery = json.encode({"forget": oldTick.id});

      channel.sink.add(forgetQuery);
    }

    //Get New ticks.
    final query = json.encode({"ticks": symbol});

    channel.sink.add(query);

    yield* channel.stream.map((event) {
      final data = json.decode(event);

      final tick = data["tick"];

      return TickModel.fromJson(tick);
    });
  }
}
