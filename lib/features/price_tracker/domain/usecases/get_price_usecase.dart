import 'package:deriv/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:deriv/core/usecase/usecase.dart';
import 'package:deriv/features/price_tracker/domain/entity/tick.dart';
import 'package:deriv/features/price_tracker/domain/repository/symbols_repository.dart';

class GetTick extends Usecase<Tick, TickParams> {
  final SymbolsRepository symbolsRepository;

  GetTick(this.symbolsRepository);

  @override
  Stream<Either<Failure, Tick>> call(TickParams params) async* {
    yield* symbolsRepository.streamTicks(params.symbol);
  }
}

class TickParams {
  final String symbol;

  TickParams(this.symbol);
}
