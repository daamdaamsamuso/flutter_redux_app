import 'package:equatable/equatable.dart';

import 'package:flutter_redux_app/models/failure_model.dart';
import 'package:flutter_redux_app/models/post_model.dart';

enum PostStatus {
  initial,
  loading,
  loaded,
  error,
}

class PostState extends Equatable {
  final Post post;
  final Failure error;
  final PostStatus status;

  PostState({
    required this.post,
    required this.error,
    required this.status,
  });

  factory PostState.initial() {
    return PostState(
      post: Post.emptyPost(),
      error: Failure(),
      status: PostStatus.initial,
    );
  }

  @override
  List<Object> get props => [post, error, status];

  @override
  bool get stringify => true;

  PostState copyWith({
    Post? post,
    Failure? error,
    PostStatus? status,
  }) {
    return PostState(
      post: post ?? this.post,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
