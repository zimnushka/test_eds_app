import 'dart:convert';

import 'package:test_eds_app/data/models/user_model.dart';
import 'package:test_eds_app/data/repositories/repository.dart';

class UsersRepository extends Repository {
  Future<List<User>> getUsers() async {
    final res = await getRequest("users", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return objects.map((e) => User.fromJson(e)).toList();
    }
    return [];
  }

  Future<User?> getUser(int id) async {
    final res = await getRequest("users/$id", headers: {});
    if (res.status == 200) {
      return User.fromJson(jsonDecode(res.data));
    }
    return null;
  }
}
