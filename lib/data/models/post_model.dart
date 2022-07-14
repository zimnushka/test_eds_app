class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post(
      {required this.body,
      required this.id,
      required this.title,
      required this.userId});

  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      body: json["body"],
      id: json["id"],
      title: json["title"],
      userId: json["userId"],
    );
  }
}
