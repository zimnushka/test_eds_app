import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_eds_app/data/models/user_model.dart';

class UserContactInfo extends StatelessWidget {
  const UserContactInfo({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(user.email),
            subtitle: const Text("email"),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: user.email));
              },
            ),
          ),
          ListTile(
            title: Text(user.phone),
            subtitle: const Text("phone"),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: user.phone));
              },
            ),
          ),
          ListTile(
            title: Text(user.website),
            subtitle: const Text("website"),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: user.website));
              },
            ),
          ),
        ],
      ),
    );
  }
}
