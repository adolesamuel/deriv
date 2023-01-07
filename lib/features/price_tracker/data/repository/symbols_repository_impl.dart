import 'package:deriv/core/network_info/network_info.dart';
import 'package:deriv/features/price_tracker/data/sources/remote_source.dart';
import 'package:deriv/features/price_tracker/domain/entity/active_symbol.dart';
import 'package:deriv/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:deriv/features/price_tracker/domain/repository/symbols_repository.dart';

class AppSymbolsRepository implements SymbolsRepository {
  final SymbolsRemoteSource symbolsRemoteSource;
  final NetworkInfo networkInfo;

  AppSymbolsRepository(this.symbolsRemoteSource, this.networkInfo);

  @override
  Stream<Either<Failure, List<ActiveSymbol>>> streamActiveSymbols() async* {
    //Returning failure in the stream
    //else returning success.

    if (await networkInfo.isConnected) {
      yield* symbolsRemoteSource.streamActiveSymbols().map(
        (event) {
          return Right<Failure, List<ActiveSymbol>>(event);
        },
      ).handleError((e) {
        final failure = CommonFailure('Unknown Failure', e.toString());
        return left(failure);
      });
    } else {
      yield const Left(
          CommonFailure('No Internet Access', 'Please connect to a Network'));
    }
  }
}