import 'package:deriv/core/failures/failure.dart';
import 'package:deriv/features/common/dropdown.dart';
import 'package:deriv/features/price_tracker/app/cubit/end_ticks_cubit/endticks_cubit.dart';
import 'package:deriv/features/price_tracker/app/cubit/get_price_cubit/get_tick_cubit.dart';
import 'package:deriv/features/price_tracker/domain/entity/active_symbol.dart';
import 'package:deriv/features/price_tracker/domain/entity/tick.dart';
import 'package:deriv/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/get_data_cubit/get_data_cubit.dart';

class PriceTrackerPage extends StatefulWidget {
  const PriceTrackerPage({super.key});

  @override
  State<PriceTrackerPage> createState() => _PriceTrackerPageState();
}

class _PriceTrackerPageState extends State<PriceTrackerPage> {
//on initstate
//load list of assets
//use list of assets to load
//price.

  GetDataCubit getDataCubit = sl<GetDataCubit>();
  GetTickCubit getTickCubit = sl<GetTickCubit>();
  EndticksCubit endticksCubit = sl<EndticksCubit>();

  ActiveSymbol? activeSymbol;
  String? selectedMarket;
  Tick? activeTick;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getDataCubit.getActiveSymbols();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataCubit, GetDataState>(
      bloc: getDataCubit,
      builder: (context, state) {
        if (state is ActiveSymbolsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ActiveSymbolsFailure) {
          return FailureWidget(
            failure: state.failure,
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 64.0,
          ),
          child: Center(
            child: Column(
              children: [
                //
                SizedBox(
                  width: 300,
                  child: AppDropdown<String>(
                    hintText: 'Select a Market',
                    activeValue: selectedMarket,
                    items: getDataCubit.markets,
                    onChanged: (value) {
                      selectedMarket = value;
                      setState(() {});
                      getDataCubit.updateAssetList(value ?? '');
                      activeSymbol = null;
                    },
                  ),
                ),

                //
                const SizedBox(
                  height: 32.0,
                ),

                //
                SizedBox(
                  width: 300,
                  child: AppDropdown<ActiveSymbol>(
                    hintText: 'Select an Asset',
                    items: getDataCubit.selectedSymbols,
                    activeValue: activeSymbol,
                    onChanged: (value) {
                      activeSymbol = value;
                      setState(() {});
                      print(activeTick?.symbol);
                      // if (activeTick != null) {
                      //   endticksCubit.stopTicks(activeTick!);
                      // }
                      getTickCubit.getTickStream(
                          activeTick, value?.symbol ?? '');
                    },
                  ),
                ),

                const SizedBox(
                  height: 32.0,
                ),
                BlocBuilder<GetTickCubit, GetTickState>(
                    bloc: getTickCubit,
                    builder: (context, tickState) {
                      if (tickState is GetTickLoading) {
                        return const SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (tickState is GetTickFailure) {
                        return FailureWidget(failure: tickState.failure);
                      } else if (tickState is GetTickSuccess) {
                        activeTick = tickState.tick;
                        print(activeTick?.quote.toString());
                        return SizedBox(
                          width: 300,
                          child: Center(
                            child: Column(
                              children: [
                                Text(activeTick?.symbol ?? ''),
                                Text(
                                  'Price: ${tickState.tick.quote.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: getTickCubit.determineColor(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FailureWidget extends StatelessWidget {
  final Failure failure;
  const FailureWidget({
    Key? key,
    required this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          const Text(
            'Error',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 20.0),
          Text(
            failure.message,
            style: const TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
