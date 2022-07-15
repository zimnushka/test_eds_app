import 'dart:convert';

import 'package:test_eds_app/data/models/user_model.dart';
import 'package:test_eds_app/data/repositories/repository.dart';

import '../models/album_model.dart';
import '../models/post_model.dart';

class UsersRepository extends Repository {
  Future<List<User>> getUsers() async {
    final res = await getRequest("users", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return objects.map((e) => User.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Post>> getUserPosts(int userId) async {
    final res = await getRequest("users/$userId/posts", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return objects.map((e) => Post.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Album>> getUserAlbums(int userId) async {
    final res = await getRequest("users/$userId/albums", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return objects.map((e) => Album.fromJson(e)).toList();
    }
    return [];
  }
}
