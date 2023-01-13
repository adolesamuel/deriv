//
//Calling this GetIt.Instance sl i.e Service Locator
import 'package:deriv/core/network_info/network_info.dart';
import 'package:deriv/features/price_tracker/app/cubit/end_ticks_cubit/endticks_cubit.dart';
import 'package:deriv/features/price_tracker/app/cubit/get_price_cubit/get_tick_cubit.dart';
import 'package:deriv/features/price_tracker/data/repository/symbols_repository_impl.dart';
import 'package:deriv/features/price_tracker/domain/repository/symbols_repository.dart';
import 'package:deriv/features/price_tracker/domain/usecases/end_ticks.dart';
import 'package:deriv/features/price_tracker/domain/usecases/get_price_usecase.dart';
import 'package:deriv/features/price_tracker/domain/usecases/get_symbols_usecase.dart';
import 'package:get_it/get_it.dart';

import 'features/price_tracker/app/cubit/get_data_cubit/get_data_cubit.dart';
import 'features/price_tracker/data/sources/remote_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
//Blocs
  sl.registerFactory(() => GetDataCubit(getSymbols: sl()));
  sl.registerFactory(() => GetTickCubit(getTick: sl()));
  sl.registerFactory(() => EndticksCubit(endTicks: sl()));

  //usecases
  sl.registerLazySingleton(() => GetSymbols(sl()));
  sl.registerLazySingleton(() => GetTick(sl()));
  sl.registerLazySingleton(() => EndTicks(sl()));

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
