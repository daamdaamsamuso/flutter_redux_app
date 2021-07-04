import 'package:flutter_redux_app/models/failure_model.dart';
import 'package:flutter_redux_app/models/post_model.dart';
import 'package:flutter_redux_app/repositories/post_respository.dart';
import 'package:flutter_redux_app/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class FetchPostsAction {}

class FetchPostsSucceededAction {
  final List<Post> posts;
  FetchPostsSucceededAction({required this.posts});
}

class FetchPostsFailedAction {
  final Failure error;
  FetchPostsFailedAction({required this.error});
}

ThunkAction<AppState> fetchPostsAndDispatch() {
  return (Store<AppState> store) async {
    store.dispatch(FetchPostsAction());

    try {
      final List<Post> posts = await PostRepository().fetchPosts();
      store.dispatch(FetchPostsSucceededAction(posts: posts));
    } on Failure catch (err) {
      store.dispatch(FetchPostsFailedAction(error: err));
    }
  };
}
