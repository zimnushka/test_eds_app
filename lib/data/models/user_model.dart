import 'package:test_eds_app/data/models/company_model.dart';

import 'address_model.dart';

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  const User({
    required this.address,
    required this.company,
    required this.email,
    required this.id,
    required this.name,
    required this.phone,
    required this.username,
    required this.website,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      address: Address.fromJson(json["address"]),
      company: Company.fromJson(json["company"]),
      email: json["email"],
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      username: json["username"],
      website: json["website"],
    );
  }
}
