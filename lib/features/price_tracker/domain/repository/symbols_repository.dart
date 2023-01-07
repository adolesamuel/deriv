import 'package:dartz/dartz.dart';
import 'package:deriv/core/failures/failure.dart';
import 'package:deriv/features/price_tracker/domain/entity/active_symbol.dart';

abstract class SymbolsRepository {
  Stream<Either<Failure, List<ActiveSymbol>>> streamActiveSymbols();
}
