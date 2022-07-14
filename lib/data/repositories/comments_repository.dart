import 'dart:convert';

import 'package:test_eds_app/data/repositories/repository.dart';

import '../models/comment_model.dart';

class CommentsRepository extends Repository {
  Future<List<Comment>> getComments() async {
    final res = await getRequest("comments", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return objects.map((e) => Comment.fromJson(e)).toList();
    }
    return [];
  }

  Future<Comment?> getComment(int id) async {
    final res = await getRequest("comments/$id", headers: {});
    if (res.status == 200) {
      return Comment.fromJson(jsonDecode(res.data));
    }
    return null;
  }
}
