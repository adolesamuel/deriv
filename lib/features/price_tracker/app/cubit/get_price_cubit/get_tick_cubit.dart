import 'package:bloc/bloc.dart';
import 'package:deriv/core/failures/failure.dart';
import 'package:deriv/features/price_tracker/domain/entity/tick.dart';
import 'package:deriv/features/price_tracker/domain/usecases/get_price_usecase.dart';
import 'package:equatable/equatable.dart';

part 'get_tick_state.dart';

class GetTickCubit extends Cubit<GetTickState> {
  final GetTick getTick;

  GetTickCubit({
    required this.getTick,
  }) : super(GetTickInitial());

  late Tick? tick;

  getTickStream(String symbol) {
    emit(GetTickLoading());

    getTick.call(TickParams(symbol)).listen((event) {
      event.fold((l) => emit(GetTickFailure(l)), (r) {
        tick = r;
        emit(GetTickSuccess(r));
      });
    });
  }
}
