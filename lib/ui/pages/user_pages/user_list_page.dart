import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
          future: repository.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      item: snapshot.data![index],
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return UserPage(id: snapshot.data![index].id);
                        }));
                      },
                    );
                  });
            }
            return LinearProgressIndicator();
          }),
    );
  }
}
