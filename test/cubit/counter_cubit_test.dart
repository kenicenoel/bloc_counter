import 'package:bloc_counter/logic/cubit/counter_cubit.dart';
import 'package:bloc_counter/logic/cubit/internet_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('CounterCubit', () {
    late CounterCubit counterCubit;
    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });
    test('Initial state of the counter object should be initialized to 0', () {
      expect(counterCubit.state, const CounterState(counterValue: 0));
    });

    blocTest(
        'Increment should emit a CounterState(counterValue: 1, wasIncremented: true) when cubit.increment() is called',
        build: () => counterCubit,
        act: (cubit) => counterCubit.increment(),
        expect: () => [const CounterState(counterValue: 1, wasIncremented: true)]);
    blocTest(
        'Decrement should emit a CounterState(counterValue: -1, wasIncremented: false) when cubit.decrement() is called',
        build: () => counterCubit,
        act: (cubit) => counterCubit.decrement(),
        expect: () => [const CounterState(counterValue: -1, wasIncremented: false)]);
  });
}
