import 'package:bloc_counter/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdScreen extends StatefulWidget {
  final String title;
  final Color color;
  const ThirdScreen({Key? key, required this.title, required this.color}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: widget.color,
          elevation: 0,
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
                    buildWhen: (previous, current) => previous.counterValue != current.counterValue,
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
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
