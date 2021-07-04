import 'package:flutter/material.dart';
import 'package:flutter_redux_app/actions/actions.dart';
import 'package:flutter_redux_app/states/states.dart';

ColorState colorReducer(ColorState colorState, dynamic action) {
  print('in ColorReducer $action');
  if (action is ChangeColorAction) {
    if (colorState.color == Colors.red) {
      return colorState.copyWith(color: Colors.green);
    } else if (colorState.color == Colors.green) {
      return colorState.copyWith(color: Colors.blue);
    } else if (colorState.color == Colors.blue) {
      return colorState.copyWith(color: Colors.red);
    }
  }
  return colorState;
}
