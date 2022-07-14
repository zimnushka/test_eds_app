import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_eds_app/data/models/user_model.dart';

class UserContactInfo extends StatelessWidget {
  const UserContactInfo({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              user.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(user.email),
            subtitle: Text("email"),
            trailing: IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: user.email));
              },
            ),
          ),
          ListTile(
            title: Text(user.phone),
            subtitle: Text("phone"),
            trailing: IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: user.phone));
              },
            ),
          ),
          ListTile(
            title: Text(user.website),
            subtitle: Text("website"),
            trailing: IconButton(
              icon: Icon(Icons.copy),
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
