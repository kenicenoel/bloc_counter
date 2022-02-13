import 'package:bloc_counter/logic/cubit/counter_cubit.dart';
import 'package:bloc_counter/logic/cubit/internet_cubit.dart';
import 'package:bloc_counter/presentation/screens/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;
  const MyApp({Key? key, required this.appRouter, required this.connectivity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: appRouter.onGenerateRoute,
        title: 'Bloc counter',
        theme: ThemeData(primarySwatch: Colors.green),
      ),
    );
  }
}
