import 'dart:convert';

import 'package:test_eds_app/data/models/album_model.dart';
import 'package:test_eds_app/data/models/photo_model.dart';
import 'package:test_eds_app/data/repositories/repository.dart';

class AlbumsRepository extends Repository {
  Future<ResponseData<List<Album>>> getAlbums(int userId) async {
    final res = await getRequest("users/$userId/albums", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return ResponseData(
          data: objects.map((e) => Album.fromJson(e)).toList(),
          isSuccesful: true,);
    }
    return const ResponseData(data: [], isSuccesful: false);
  }

  Future<ResponseData<List<Photo>>> getAlbum(int id) async {
    final res = await getRequest("albums/$id/photos", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return ResponseData(
          data: objects.map((e) => Photo.fromJson(e)).toList(),
          isSuccesful: true,);
    }
    return const ResponseData(data: [], isSuccesful: false);
  }
}
