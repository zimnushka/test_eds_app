import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/user_model.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.item, this.onTap}) : super(key: key);
  final User item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(item.username),
      subtitle: Text(item.name),
    );
  }
}
