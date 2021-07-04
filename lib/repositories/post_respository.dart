import 'dart:convert';

import 'package:flutter_redux_app/models/failure_model.dart';
import 'package:flutter_redux_app/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final Uri uri = Uri.parse(baseUrl);
    List<Post> posts;

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw 'Failed to fetch posts';
      }

      final responseBody = json.decode(response.body);
      posts = responseBody.map<Post>((post) => Post.fromJson(post)).toList();

      return posts;
    } catch (err) {
      throw Failure(message: err.toString());
    }
  }

  Future<Post> fetchPost(int postId) async {
    final Uri uri = Uri.parse('$baseUrl/$postId');
    Post post;

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw 'Failed to fetch post';
      }

      final responseBody = json.decode(response.body);
      post = Post.fromJson(responseBody);

      return post;
    } catch (err) {
      throw Failure(message: err.toString());
    }
  }
}
