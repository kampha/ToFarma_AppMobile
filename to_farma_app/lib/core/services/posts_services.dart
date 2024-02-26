import 'package:flutter/material.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/server/server.dart';
import 'package:http/http.dart' as http;

import '../shared_preferences/preferences_user.dart';

class PostsServices extends ChangeNotifier {
  final String prefix = LaravelConfig.prefix;
  final config = LaravelConfig();
  final List<Post> lstPost = [];

  Future<List<Post>> getPosts() async {
    lstPost.clear();
    final url = Uri.https(LaravelConfig.baseUrl, '$prefix/post');
    String token = LaravelConfig.token;
    final respuesta = await http.get(url, headers: config.header(SharedPreferencesService.getToken));
    if (respuesta.body != '[]' && respuesta.statusCode == 200) {
      final List<Post> postsList = [];
      final resp = postFromJson(respuesta.body);
      if (resp.isNotEmpty) {
        lstPost.addAll(resp);
        postsList.addAll(resp);
      }
      return postsList;
    }

    return lstPost;
  }
}
