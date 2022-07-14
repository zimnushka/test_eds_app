class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  const Company(
      {required this.bs, required this.catchPhrase, required this.name,});

  static Company fromJson(Map<String, dynamic> json) {
    return Company(
      bs: json["bs"],
      catchPhrase: json["catchPhrase"],
      name: json["name"],
    );
  }
}
