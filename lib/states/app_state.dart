import 'package:equatable/equatable.dart';

import 'package:flutter_redux_app/states/color_state.dart';
import 'package:flutter_redux_app/states/post_state.dart';
import 'package:flutter_redux_app/states/states.dart';

class AppState extends Equatable {
  final ColorState colorState;
  final CounterState counterState;
  final PostsState postsState;
  final PostState postState;
  AppState({
    required this.colorState,
    required this.counterState,
    required this.postsState,
    required this.postState,
  });

  @override
  List<Object> get props => [colorState, counterState, postsState, postState];

  @override
  bool get stringify => true;
}
