import 'package:bloc_counter/constants/enums.dart';
import 'package:bloc_counter/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final Color color;
  const HomeScreen({Key? key, required this.title, required this.color}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        final counterCubit = BlocProvider.of<CounterCubit>(context);
        if (state is InternetConnected && state.connectionType == ConnectionType.wifi) {
          counterCubit.increment();
        } else if (state is InternetConnected && state.connectionType == ConnectionType.mobile) {
          counterCubit.decrement();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: widget.color,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                    if (state is InternetConnected) {
                      return Icon(state.connectionType == ConnectionType.mobile
                          ? Icons.network_cell_outlined
                          : Icons.network_wifi_outlined);
                    }
                    return const Icon(Icons.cloud_off_outlined);
                  },
                ),
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        onPressed: () => BlocProvider.of<CounterCubit>(context).increment(),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(20.0),
                    ),
                    BlocConsumer<CounterCubit, CounterState>(
                      listener: (context, state) {
                        if (state.wasIncremented) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Incremented'),
                            duration: Duration(milliseconds: 300),
                          ));
                        }
                      },
                      builder: (context, state) {
                        return Text(
                          state.counterValue.toString(),
                          style: TextStyle(
                              color: state.counterValue <= 5 ? Colors.black : widget.color,
                              fontSize: 30),
                        );
                      },
                      buildWhen: (previous, current) =>
                          previous.counterValue != current.counterValue,
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () => BlocProvider.of<CounterCubit>(context).decrement(),
                        icon: const Icon(Icons.remove, color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(20.0),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () => Navigator.of(context).pushNamed('/second'),
                      color: widget.color,
                      shape: ShapeBorder.lerp(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          0.5),
                      elevation: 0,
                      child: const Text('Screen 2'),
                    ),
                    MaterialButton(
                      onPressed: () => Navigator.of(context).pushNamed('/third'),
                      color: widget.color,
                      shape: ShapeBorder.lerp(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          0.5),
                      elevation: 0,
                      child: const Text('Screen 3'),
                    )
                  ],
                )
              ],
            ),
          ) // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
