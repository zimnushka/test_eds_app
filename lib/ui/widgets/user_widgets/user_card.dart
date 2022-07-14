import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/user_model.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.item, this.onTap}) : super(key: key);
  final User item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      leading: Card(
        color: Theme.of(context).disabledColor,
        child: SizedBox(
            width: 40,
            height: 40,
            child: Center(
                child: Text(
              item.id.toString(),
              style:
                  TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
            ),),),
      ),
      onTap: onTap,
      title: Text(item.username),
      subtitle: Text(item.name),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
