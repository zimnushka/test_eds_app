import 'package:hive/hive.dart';

class Album {
  final int id;
  final int userId;
  final String title;

  const Album({required this.title, required this.userId, required this.id});

  static Album fromJson(Map<String, dynamic> json) {
    return Album(
      title: json["title"],
      userId: json["userId"],
      id: json["id"],
    );
  }
}

class AlbumAdapter extends TypeAdapter<Album> {
  @override
  Album read(BinaryReader reader) {
    final int id = reader.readInt();
    final int userId = reader.readInt();
    final String title = reader.readString();
    return Album(title: title, userId: userId, id: id);
  }

  @override
  int get typeId => 4;

  @override
  void write(BinaryWriter writer, Album obj) {
    writer.writeInt(obj.id);
    writer.writeInt(obj.userId);
    writer.writeString(obj.title);
  }
}
