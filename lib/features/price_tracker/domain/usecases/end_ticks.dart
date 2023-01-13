import 'package:deriv/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:deriv/core/usecase/usecase.dart';
import 'package:deriv/features/price_tracker/domain/entity/tick.dart';
import 'package:deriv/features/price_tracker/domain/repository/symbols_repository.dart';
import 'package:deriv/features/price_tracker/domain/usecases/get_price_usecase.dart';

class EndTicks extends Usecase<void, EndTickParams> {
  final SymbolsRepository symbolsRepository;

  EndTicks(this.symbolsRepository);

  @override
  Stream<Either<Failure, void>> call(EndTickParams params) async* {
    yield* symbolsRepository.endTicks(params.tick);
  }
}

class EndTickParams {
  final Tick tick;

  EndTickParams(this.tick);
}
