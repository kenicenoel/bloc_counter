import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_counter/logic/cubit/internet_cubit.dart';
import 'package:equatable/equatable.dart';

import '../../constants/enums.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(counterValue: 0));

  void increment() =>
      emit(CounterState(counterValue: state.counterValue + 1, wasIncremented: true));
  void decrement() => emit(CounterState(counterValue: state.counterValue - 1));
}
