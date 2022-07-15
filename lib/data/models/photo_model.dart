import 'package:hive/hive.dart';

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.thumbnailUrl,
    required this.title,
    required this.url,
  });

  static Photo fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json["albumId"],
      id: json["id"],
      thumbnailUrl: json["thumbnailUrl"],
      title: json["title"],
      url: json["url"],
    );
  }
}

class PhotoAdapter extends TypeAdapter<Photo> {
  @override
  Photo read(BinaryReader reader) {
    final int albumId = reader.readInt();
    final int id = reader.readInt();
    final String title = reader.readString();
    final String url = reader.readString();
    final String thumbnailUrl = reader.readString();
    return Photo(
        albumId: albumId,
        id: id,
        thumbnailUrl: thumbnailUrl,
        title: title,
        url: url);
  }

  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, Photo obj) {
    writer.writeInt(obj.albumId);
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.url);
    writer.writeString(obj.thumbnailUrl);
  }
}
