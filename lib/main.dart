import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_eds_app/app.dart';
import 'package:test_eds_app/data/models/album_model.dart';
import 'package:test_eds_app/data/models/comment_model.dart';
import 'package:test_eds_app/data/models/photo_model.dart';
import 'package:test_eds_app/data/models/post_model.dart';
import 'package:test_eds_app/data/models/user_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(AlbumAdapter());
  runApp(const MyApp());
}
