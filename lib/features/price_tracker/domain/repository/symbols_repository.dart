import 'package:dartz/dartz.dart';
import 'package:deriv/core/failures/failure.dart';
import 'package:deriv/features/price_tracker/domain/entity/active_symbol.dart';
import 'package:deriv/features/price_tracker/domain/entity/tick.dart';

abstract class SymbolsRepository {
  Stream<Either<Failure, List<ActiveSymbol>>> streamActiveSymbols();
  Stream<Either<Failure, Tick>> streamTicks(Tick? oldTick, String symbol);
  Stream<Either<Failure, void>> endTicks(Tick tick);
}
