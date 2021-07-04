import 'package:flutter/material.dart';
import 'package:flutter_redux_app/actions/actions.dart';
import 'package:flutter_redux_app/states/states.dart';

CounterState counterReducer(CounterState counterState, dynamic action) {
  print('in counterReducer: $action');

  if (action is IncrementAction) {
    if (action.color == Colors.red)
      return counterState.copyWith(counter: counterState.counter + 1);
    else if (action.color == Colors.green)
      return counterState.copyWith(counter: counterState.counter + 2);
    else if (action.color == Colors.blue)
      return counterState.copyWith(counter: counterState.counter + 3);
  } else if (action is DecrementAction) {
    if (action.color == Colors.red)
      return counterState.copyWith(counter: counterState.counter - 1);
    else if (action.color == Colors.green)
      return counterState.copyWith(counter: counterState.counter - 2);
    else if (action.color == Colors.blue)
      return counterState.copyWith(counter: counterState.counter - 3);
  }
  return counterState;
}
