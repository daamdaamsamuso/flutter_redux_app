import 'package:flutter_redux_app/reducers/posts_reducer.dart';
import 'package:flutter_redux_app/reducers/reducers.dart';
import 'package:flutter_redux_app/states/app_state.dart';

AppState appReducer(AppState state, action) {
  print(state);
  print(action);

  return AppState(
    colorState: colorReducer(state.colorState, action),
    counterState: counterReducer(state.counterState, action),
    postsState: postsReducer(state.postsState, action),
    postState: postReducer(state.postState, action),
  );
}
