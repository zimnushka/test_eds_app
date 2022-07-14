import 'dart:convert';

import 'package:test_eds_app/data/models/album_model.dart';
import 'package:test_eds_app/data/repositories/repository.dart';

class AlbumsRepository extends Repository {
  Future<List<Album>> getAlbums() async {
    final res = await getRequest("albums", headers: {});
    if (res.status == 200) {
      List objects = jsonDecode(res.data);
      return objects.map((e) => Album.fromJson(e)).toList();
    }
    return [];
  }

  Future<Album?> getAlbum(int id) async {
    final res = await getRequest("albums/$id", headers: {});
    if (res.status == 200) {
      return Album.fromJson(jsonDecode(res.data));
    }
    return null;
  }
}
