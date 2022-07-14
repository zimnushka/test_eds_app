import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/user_model.dart';
import 'package:test_eds_app/data/repositories/users_repository.dart';
import 'package:test_eds_app/ui/widgets/user_card.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final UsersRepository repository = UsersRepository();
  List<User> users = [];

  @override
  void initState() {
    repository.getUsers().then((value) {
      users = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return UserCard(item: users[index]);
          }),
    );
  }
}
