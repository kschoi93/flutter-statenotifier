// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

import 'bg_color.dart';

class CounterState extends Equatable {
  final int counter;
  CounterState({
    required this.counter,
  });

  @override
  String toString() => 'CounterState(counter: $counter)';

  @override
  // TODO: implement props
  List<Object?> get props => [counter];

  @override
  bool get stringify => true;

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}

class Counter extends StateNotifier<CounterState> with LocatorMixin {
  Counter() : super(CounterState(counter: 0));

  void increment() {
    print(read<BgColor>().state);
    print(state.toString());
    print(state.props);
    Color currentColor = read<BgColor>().state.color;

    if (currentColor == Colors.black) {
      state = state.copyWith(counter: state.counter + 10);
    } else if (currentColor == Colors.red) {
      state = state.copyWith(counter: state.counter - 10);
    } else {
      state = state.copyWith(counter: state.counter + 1);
    }
  }

  @override
  void update(Locator watch) {
    print('in counter statenofifier: ${watch<BgColorState>().color}');
    print('in counter statenofifier: ${watch<BgColor>().state.color}');
    super.update(watch);
  }
}
