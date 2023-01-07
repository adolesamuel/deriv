import 'package:deriv/features/common/dropdown.dart';
import 'package:deriv/features/price_tracker/app/cubit/get_price_cubit/get_tick_cubit.dart';
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
  GetTickCubit getPriceCubit = sl<GetTickCubit>();

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
        print(state);
        if (state is ActiveSymbolsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ActiveSymbolsFailure) {
          return Center(
            child: Column(
              children: [
                //
                const Text('Error'),
                const SizedBox(height: 20.0),
                Text(state.failure.message),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: AppDropdown<String>(
                    hintText: 'Select a Market',
                    items: getDataCubit.markets,
                    onChanged: (value) {
                      getDataCubit.updateAssetList(value ?? '');
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                SizedBox(
                  width: 300,
                  child: AppDropdown(
                    hintText: 'Select an Asset',
                    items: getDataCubit.selectedSymbols,
                    onChanged: (value) {
                      // getDataCubit.getPriceStream();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
