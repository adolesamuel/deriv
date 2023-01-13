import 'package:bloc/bloc.dart';
import 'package:deriv/core/failures/failure.dart';
import 'package:deriv/features/price_tracker/domain/entity/tick.dart';
import 'package:deriv/features/price_tracker/domain/usecases/get_price_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'get_tick_state.dart';

class GetTickCubit extends Cubit<GetTickState> {
  final GetTick getTick;

  GetTickCubit({
    required this.getTick,
  }) : super(GetTickInitial());

  late Tick? tick;

  ///This list takes only two items.
  List<double> priceList = [0, 0];

  getTickStream(Tick? oldTick, String symbol) {
    emit(GetTickLoading());

    getTick.call(TickParams(oldTick, symbol)).listen((event) {
      event.fold((l) => emit(GetTickFailure(l)), (r) {
        tick = r;
        renewPriceList(r.quote);
        emit(GetTickSuccess(r));
      });
    });
  }

  void renewPriceList(double value) {
    priceList[0] = priceList[1];
    priceList[1] = value;
  }

  Color determineColor() {
    if (priceList[0] == priceList[1]) {
      return Colors.grey;
    } else if (priceList[0] > priceList[1]) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}
