import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_app/actions/actions.dart';
import 'package:flutter_redux_app/pages/post_page.dart';

import 'package:flutter_redux_app/states/states.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: StoreConnector<AppState, _PostViewModel>(
        onInit: (store) => store.dispatch(fetchPostsAndDispatch()),
        converter: (store) => _PostViewModel(
          state: store.state.postsState,
        ),
        builder: (context, _PostViewModel postsVM) {
          if (postsVM.state.status == PostsStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (postsVM.state.status == PostsStatus.error) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('${postsVM.state.error.message}'),
                  );
                },
              );
            });
          }
          if (postsVM.state.posts.length == 0) {
            return Center(
                child: Text(
              'No Posts',
              style: TextStyle(fontSize: 20.0),
            ));
          }

          return ListView.builder(
            itemCount: postsVM.state.posts.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return PostPage(
                          postId: postsVM.state.posts[index].id,
                        );
                      }),
                    );
                  },
                  title: Text(postsVM.state.posts[index].title),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _PostViewModel {
  final PostsState state;
  _PostViewModel({
    required this.state,
  });
}
