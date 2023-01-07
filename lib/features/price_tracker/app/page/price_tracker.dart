import 'package:deriv/features/common/dropdown.dart';
import 'package:deriv/features/price_tracker/app/bloc/cubit/get_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataCubit, GetDataState>(
      builder: (context, state) {
        if (state is ActiveSymbolsLoading) {
          return const CircularProgressIndicator();
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
          child: Center(
            child: Column(
              children: const [
                SizedBox(
                    width: 300,
                    child: AppDropdown(hintText: 'Select a Market', items: [])),
                SizedBox(
                  height: 32.0,
                ),
                SizedBox(
                    width: 300,
                    child: AppDropdown(hintText: 'Select an Asset', items: [])),
              ],
            ),
          ),
        );
      },
    );
  }
}
