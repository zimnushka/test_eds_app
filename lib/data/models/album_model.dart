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
