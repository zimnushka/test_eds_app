class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Coord geo;

  const Address(
      {required this.city,
      required this.geo,
      required this.street,
      required this.suite,
      required this.zipcode});

  static Address fromJson(Map<String, dynamic> json) {
    return Address(
      city: json["city"],
      geo: Coord(double.tryParse(json["geo"]["lat"]) ?? 0,
          double.tryParse(json["geo"]["lng"]) ?? 0),
      street: json["street"],
      suite: json["suite"],
      zipcode: json["zipcode"],
    );
  }
}

class Coord {
  final double lat;
  final double lng;
  const Coord(this.lat, this.lng);
}
