import 'dart:convert';

import 'package:deriv/core/api/endpoints.dart';
import 'package:deriv/features/price_tracker/data/models/active_symbol_model.dart';
import 'package:web_socket_channel/io.dart';

abstract class SymbolsRemoteSource {
  Stream<List<ActiveSymbolModel>> streamActiveSymbols();
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
      print('making another sink addittion');
      channel.sink.add(query);
    });

    yield* channel.stream.map((event) {
      final data = json.decode(event);
      final List activeSymbols = data["active_symbols"];

      return activeSymbols.map((e) => ActiveSymbolModel.fromJson(e)).toList();
    });
  }
}
