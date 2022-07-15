import 'dart:convert';

import 'package:test_eds_app/data/models/user_model.dart';
import 'package:test_eds_app/data/repositories/repository.dart';

import '../models/album_model.dart';
import '../models/post_model.dart';

class UsersRepository extends Repository {
  Future<ResponseData<List<User>>> getUsers() async {
    final res = await getRequest("users", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return ResponseData(
          data: objects.map((e) => User.fromJson(e)).toList(),
          isSuccesful: true,);
    }
    return const ResponseData(data: [], isSuccesful: false);
  }

  Future<ResponseData<List<Post>>> getUserPosts(int userId) async {
    final res = await getRequest("users/$userId/posts", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return ResponseData(
          data: objects.map((e) => Post.fromJson(e)).toList(),
          isSuccesful: true,);
    }
    return const ResponseData(data: [], isSuccesful: false);
  }

  Future<ResponseData<List<Album>>> getUserAlbums(int userId) async {
    final res = await getRequest("users/$userId/albums", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return ResponseData(
          data: objects.map((e) => Album.fromJson(e)).toList(),
          isSuccesful: true,);
    }
    return const ResponseData(data: [], isSuccesful: false);
  }
}
