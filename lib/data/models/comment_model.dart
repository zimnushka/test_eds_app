class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const Comment(
      {required this.body,
      required this.email,
      required this.id,
      required this.name,
      required this.postId});

  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(
      body: json["body"],
      email: json["email"],
      id: json["id"],
      name: json["name"],
      postId: json["postId"],
    );
  }
}
