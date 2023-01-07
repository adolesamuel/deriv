part of 'get_tick_cubit.dart';

abstract class GetTickState extends Equatable {
  const GetTickState();

  @override
  List<Object> get props => [];
}

class GetTickInitial extends GetTickState {}

class GetTickLoading extends GetTickState {}

class GetTickFailure extends GetTickState {
  final Failure failure;

  const GetTickFailure(this.failure);
}

class GetTickSuccess extends GetTickState {
  final Tick tick;

  const GetTickSuccess(this.tick);

  @override
  List<Object> get props => [tick.quote];
}
