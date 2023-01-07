// ignore_for_file: overridden_fields

import 'package:equatable/equatable.dart';

//Failure class for handling failure objects
abstract class Failure extends Equatable {
  final String title;
  final String message;

  const Failure(this.title, this.message);

  @override
  List<Object> get props => [title, message];
}

///For Server Failure Exceptions
class ServerFailure extends Failure {
  @override
  final String title;
  @override
  final String message;
  const ServerFailure(this.title, this.message) : super(title, message);
}

///For Cache Failure Exceptions
class CacheFailure extends Failure {
  @override
  final String title;
  @override
  final String message;

  const CacheFailure(this.title, this.message) : super(title, message);
}

///For Common Failure Exceptions
class CommonFailure extends Failure {
  @override
  final String title;

  // ignore: annotate_overrides
  final String message;
  const CommonFailure(this.title, this.message) : super(title, message);
}

///For Internet failure exceptions
class InternetFailure extends Failure {
  const InternetFailure(final String title, final String message)
      : super(title, message);
}
