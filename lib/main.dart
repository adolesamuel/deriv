import 'package:deriv/features/price_tracker/app/page/price_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/price_tracker/app/cubit/get_data_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  //set up dependency injection
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GetDataCubit getDataCubit = di.sl<GetDataCubit>();
    return MultiBlocProvider(
      providers: [
        //GetDataCubit
        BlocProvider<GetDataCubit>(
          create: (context) => getDataCubit,
        ),
      ],
      child: MaterialApp(
        title: 'Deriv Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const MyHomePage(title: 'Price Tracker'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const PriceTrackerPage(),
    );
  }
}
