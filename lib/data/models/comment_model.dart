import 'package:hive/hive.dart';

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const Comment({
    required this.body,
    required this.email,
    required this.id,
    required this.name,
    required this.postId,
  });

  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(
      body: json["body"],
      email: json["email"],
      id: json["id"],
      name: json["name"],
      postId: json["postId"],
    );
  }

  Map get toJson =>
      {"postId": postId, "name": name, "email": email, "body": body};
}

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  Comment read(BinaryReader reader) {
    final int postId = reader.readInt();
    final int id = reader.readInt();
    final String name = reader.readString();
    final String email = reader.readString();
    final String body = reader.readString();
    return Comment(
        body: body, email: email, id: id, name: name, postId: postId,);
  }

  @override
  int get typeId => 3;

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer.writeInt(obj.postId);
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.email);
    writer.writeString(obj.body);
  }
}
