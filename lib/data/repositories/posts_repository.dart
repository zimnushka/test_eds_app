import 'dart:convert';

import 'package:test_eds_app/data/models/post_model.dart';
import 'package:test_eds_app/data/repositories/repository.dart';

class PostsRepository extends Repository {
  Future<ResponseData<List<Post>>> getPosts(int userId) async {
    final res = await getRequest("users/$userId/posts", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return ResponseData(
          data: objects.map((e) => Post.fromJson(e)).toList(),
          isSuccesful: true);
    }
    return const ResponseData(data: [], isSuccesful: false);
  }

  // Future<Post?> getPost(int id) async {
  //   final res = await getRequest("posts/$id", headers: {});
  //   if (res.status == 200) {
  //     return Post.fromJson(jsonDecode(res.data));
  //   }
  //   return null;
  // }
}
