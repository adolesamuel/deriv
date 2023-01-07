import 'package:dartz/dartz.dart';
import 'package:deriv/core/failures/failure.dart';

abstract class Usecase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

class NoParams {}
