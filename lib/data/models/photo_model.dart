class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo(
      {required this.albumId,
      required this.id,
      required this.thumbnailUrl,
      required this.title,
      required this.url,});

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
