import 'package:flutter_redux_app/actions/actions.dart';
import 'package:flutter_redux_app/states/states.dart';

PostsState postsReducer(PostsState postsState, action) {
  print('in postReducer, $action');

  if (action is FetchPostsAction) {
    return postsState.copyWith(status: PostsStatus.loading);
  } else if (action is FetchPostsSucceededAction) {
    return postsState.copyWith(
      posts: action.posts,
      status: PostsStatus.loaded,
    );
  } else if (action is FetchPostsFailedAction) {
    return postsState.copyWith(
      error: action.error,
      status: PostsStatus.error,
    );
  }
  return postsState;
}
