import 'package:hive/hive.dart';
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

class UserAdapter extends TypeAdapter<User> {
  @override
  User read(BinaryReader reader) {
    final int id = reader.readInt();
    final String name = reader.readString();
    final String username = reader.readString();
    final String email = reader.readString();
    final String phone = reader.readString();
    final String website = reader.readString();
    final Address address = Address(
      city: reader.readString(),
      street: reader.readString(),
      zipcode: reader.readString(),
      suite: reader.readString(),
      geo: Coord(
        reader.readDouble(),
        reader.readDouble(),
      ),
    );
    final Company company = Company(
      bs: reader.readString(),
      catchPhrase: reader.readString(),
      name: reader.readString(),
    );
    return User(
        address: address,
        company: company,
        email: email,
        id: id,
        name: name,
        phone: phone,
        username: username,
        website: website);
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, User obj) {
    //write user
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.username);
    writer.writeString(obj.email);
    writer.writeString(obj.phone);
    writer.writeString(obj.website);
    //Write address
    writer.writeString(obj.address.city);
    writer.writeString(obj.address.street);
    writer.writeString(obj.address.zipcode);
    writer.writeString(obj.address.suite);
    writer.writeDouble(obj.address.geo.lat);
    writer.writeDouble(obj.address.geo.lng);
    //Write company
    writer.writeString(obj.company.bs);
    writer.writeString(obj.company.catchPhrase);
    writer.writeString(obj.company.name);
  }
}
