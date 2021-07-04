import 'package:equatable/equatable.dart';

import 'package:flutter_redux_app/models/failure_model.dart';
import 'package:flutter_redux_app/models/post_model.dart';

enum PostsStatus {
  initial,
  loading,
  loaded,
  error,
}

class PostsState extends Equatable {
  final List<Post> posts;
  final Failure error;
  final PostsStatus status;
  PostsState({
    required this.posts,
    required this.error,
    required this.status,
  });

  factory PostsState.initial() {
    return PostsState(
      posts: [],
      error: Failure(),
      status: PostsStatus.initial,
    );
  }

  @override
  List<Object> get props => [posts, error, status];

  @override
  bool get stringify => true;

  PostsState copyWith({
    List<Post>? posts,
    Failure? error,
    PostsStatus? status,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
