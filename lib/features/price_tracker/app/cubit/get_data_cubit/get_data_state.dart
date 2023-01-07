part of 'get_data_cubit.dart';

@immutable
abstract class GetDataState {}

class GetDataInitial extends GetDataState {}

class ActiveSymbolsFetched extends GetDataState {
  final List<ActiveSymbol> activeSymbols;

  ActiveSymbolsFetched(this.activeSymbols);
}

class ActiveSymbolsLoading extends GetDataState {}

class ActiveSymbolsFailure extends GetDataState {
  final Failure failure;

  ActiveSymbolsFailure(this.failure);
}
