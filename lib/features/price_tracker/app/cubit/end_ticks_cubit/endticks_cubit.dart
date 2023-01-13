import 'package:bloc/bloc.dart';
import 'package:deriv/features/price_tracker/domain/entity/tick.dart';
import 'package:deriv/features/price_tracker/domain/usecases/end_ticks.dart';
import 'package:equatable/equatable.dart';

part 'endticks_state.dart';

class EndticksCubit extends Cubit<EndticksState> {
  final EndTicks endTicks;
  EndticksCubit({
    required this.endTicks,
  }) : super(EndticksInitial());

  stopTicks(Tick tick) {
    final params = EndTickParams(tick);
    endTicks.call(params);
  }
}
