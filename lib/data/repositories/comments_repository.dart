import 'dart:convert';

import 'package:test_eds_app/data/repositories/repository.dart';

import '../models/comment_model.dart';

class CommentsRepository extends Repository {
  Future<List<Comment>> getComments(int postId) async {
    final res = await getRequest("posts/$postId/comments", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return objects.map((e) => Comment.fromJson(e)).toList();
    }
    return [];
  }

  Future<Comment?> sendComment(Comment comment) async {
    final res = await postRequest(
        url: "comments",
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        parametrs: jsonEncode(comment.toJson));
    if (res.status == 201) {
      return Comment.fromJson(jsonDecode(res.data));
    }
    return null;
  }
}
