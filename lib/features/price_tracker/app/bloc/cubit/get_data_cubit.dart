import 'package:bloc/bloc.dart';
import 'package:deriv/features/price_tracker/domain/usecases/get_symbols_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../../core/failures/failure.dart';
import '../../../domain/entity/active_symbol.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  final GetSymbols getSymbols;
  GetDataCubit({
    required this.getSymbols,
  }) : super(GetDataInitial());

  List<ActiveSymbol> symbols = [];

  //call the use case

  getActiveSymbols() async {
    emit(ActiveSymbolsLoading());

    //get all unrepeated markets from symbols.

    //emit active symbol error or success.
  }
}
