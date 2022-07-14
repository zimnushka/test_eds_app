import 'dart:convert';

import 'package:test_eds_app/data/models/post_model.dart';
import 'package:test_eds_app/data/repositories/repository.dart';

class PostsRepository extends Repository {
  Future<List<Post>> getPosts() async {
    final res = await getRequest("posts", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return objects.map((e) => Post.fromJson(e)).toList();
    }
    return [];
  }

  Future<Post?> getPost(int id) async {
    final res = await getRequest("posts/$id", headers: {});
    if (res.status == 200) {
      return Post.fromJson(jsonDecode(res.data));
    }
    return null;
  }
}
