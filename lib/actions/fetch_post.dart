import 'package:flutter_redux_app/models/failure_model.dart';
import 'package:flutter_redux_app/models/post_model.dart';
import 'package:flutter_redux_app/repositories/post_respository.dart';
import 'package:flutter_redux_app/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class FetchPostAction {}

class FetchPostSucceededAction {
  final Post post;
  FetchPostSucceededAction({
    required this.post,
  });
}

class FetchPostFailedAction {
  final Failure error;
  FetchPostFailedAction({
    required this.error,
  });
}

ThunkAction<AppState> fetchPostAndDispatch(int postId) {
  return (Store<AppState> store) async {
    store.dispatch(FetchPostAction());

    try {
      final Post post = await PostRepository().fetchPost(postId);
      store.dispatch(FetchPostSucceededAction(post: post));
    } on Failure catch (err) {
      store.dispatch(FetchPostFailedAction(error: err));
    }
  };
}
