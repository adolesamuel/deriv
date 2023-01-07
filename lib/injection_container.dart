//
//Calling this GetIt.Instance sl i.e Service Locator
import 'package:deriv/core/network_info/network_info.dart';
import 'package:deriv/features/price_tracker/data/repository/symbols_repository_impl.dart';
import 'package:deriv/features/price_tracker/domain/repository/symbols_repository.dart';
import 'package:get_it/get_it.dart';

import 'features/price_tracker/data/sources/remote_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Application [REPOSITORIES]
  ///////////////////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton<SymbolsRepository>(() => AppSymbolsRepository(
        sl(),
        sl(),
      ));
  ///////////////////////////////////////////////////////////////////////////////////
  ///Application [DATA_SOURCES]
  ///////////////////////////////////////////////////////////////////////////////////

  sl.registerLazySingleton<SymbolsRemoteSource>(() => AppSymbolsRemoteSource());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}