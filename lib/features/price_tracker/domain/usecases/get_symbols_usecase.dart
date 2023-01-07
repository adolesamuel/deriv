import 'package:deriv/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:deriv/core/usecase/usecase.dart';
import 'package:deriv/features/price_tracker/domain/entity/active_symbol.dart';
import 'package:deriv/features/price_tracker/domain/repository/symbols_repository.dart';

class GetSymbols extends Usecase<List<ActiveSymbol>, NoParams> {
  final SymbolsRepository symbolsRepository;

  GetSymbols(this.symbolsRepository);

  @override
  Stream<Either<Failure, List<ActiveSymbol>>> call(NoParams params) async* {
    print('usecase running');
    yield* symbolsRepository.streamActiveSymbols();
  }
}
