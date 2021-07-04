import 'package:flutter_redux_app/actions/actions.dart';
import 'package:flutter_redux_app/states/states.dart';

PostState postReducer(PostState postState, action) {
  if (action is FetchPostAction) {
    return postState.copyWith(status: PostStatus.loading);
  } else if (action is FetchPostSucceededAction) {
    return postState.copyWith(post: action.post, status: PostStatus.loaded);
  } else if (action is FetchPostFailedAction) {
    return postState.copyWith(error: action.error, status: PostStatus.error);
  }
  return postState;
}
