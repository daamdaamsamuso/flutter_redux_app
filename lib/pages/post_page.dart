import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_app/actions/actions.dart';
import 'package:flutter_redux_app/models/post_model.dart';

import 'package:flutter_redux_app/states/states.dart';

class PostPage extends StatelessWidget {
  final int postId;
  const PostPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: StoreConnector<AppState, _PostViewModel>(
        onInit: (store) => store.dispatch(fetchPostAndDispatch(postId)),
        converter: (store) => _PostViewModel(state: store.state.postState),
        builder: (context, _PostViewModel postVM) {
          if (postVM.state.status == PostStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (postVM.state.status == PostStatus.error) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('${postVM.state.error.message}'),
                  );
                },
              );
            });
          }

          if (postVM.state.post == Post.emptyPost()) {
            return Center(
              child: Text(
                'No Post',
                style: TextStyle(fontSize: 20.0),
              ),
            );
          }

          return ListView(
            children: [
              SizedBox(height: 20.0),
              Text(
                'Post Detail',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              Card(
                child: ListTile(
                  title: Text('id: ${postVM.state.post.id}'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('userId: ${postVM.state.post.userId}'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('title: ${postVM.state.post.title}'),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('body: ${postVM.state.post.body}'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PostViewModel {
  final PostState state;
  _PostViewModel({
    required this.state,
  });
}
