import 'package:hive/hive.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.body,
    required this.id,
    required this.title,
    required this.userId,
  });

  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      body: json["body"],
      id: json["id"],
      title: json["title"],
      userId: json["userId"],
    );
  }
}

class PostAdapter extends TypeAdapter<Post> {
  @override
  Post read(BinaryReader reader) {
    final int userId = reader.readInt();
    final int id = reader.readInt();
    final String title = reader.readString();
    final String body = reader.readString();
    return Post(body: body, id: id, title: title, userId: userId);
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Post obj) {
    writer.writeInt(obj.userId);
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.body);
  }
}
