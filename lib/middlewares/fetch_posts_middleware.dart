import 'package:flutter_redux_app/actions/actions.dart';
import 'package:flutter_redux_app/models/failure_model.dart';
import 'package:flutter_redux_app/models/post_model.dart';
import 'package:flutter_redux_app/repositories/post_respository.dart';
import 'package:flutter_redux_app/states/states.dart';
import 'package:redux/redux.dart';

void fetchPostsMiddleware(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,
) {
  if (action is FetchPostsAction) {
    final api = PostRepository();

    api.fetchPosts().then((List<Post> posts) {
      store.dispatch(FetchPostsSucceededAction(posts: posts));
    }).catchError((error) {
      store.dispatch(FetchPostsFailedAction(
          error: Failure(message: 'Failed to fetch posts')));
    });
  }
  next(action);
}
