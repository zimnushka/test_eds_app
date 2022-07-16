import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test_eds_app/data/models/user_model.dart';
import 'package:test_eds_app/data/repositories/users_repository.dart';
import 'package:test_eds_app/ui/pages/user_pages/user_page.dart';
import 'package:test_eds_app/ui/widgets/user_widgets/user_card.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final UsersRepository repository = UsersRepository();
  Box<User>? usersBox;

  Future<List<User>> load() async {
    if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (usersBox == null || usersBox?.isOpen != true) {
      usersBox = await Hive.openBox<User>('user');
    }

    List<User> users = usersBox!.values.toList();
    if (users.isEmpty) {
      users = (await repository.getUsers()).data;
      usersBox!.addAll(users);
    } else {
      repository.getUsers().then((value) {
        if (value.isSuccesful == true) {
          if (!mounted) return;
          usersBox!.clear();
          usersBox!.addAll(value.data);
        }
      });
    }
    return users;
  }

  @override
  void dispose() {
    usersBox!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: FutureBuilder<List<User>>(
        future: load(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return UserCard(
                  item: snapshot.data![index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return UserPage(user: snapshot.data![index]);
                        },
                      ),
                    );
                  },
                );
              },
            );
          }
          return const LinearProgressIndicator();
        },
      ),
    );
  }
}
