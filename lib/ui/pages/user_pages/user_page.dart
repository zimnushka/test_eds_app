import 'package:flutter/material.dart';
import 'package:test_eds_app/data/repositories/users_repository.dart';
import 'package:test_eds_app/ui/widgets/user_widgets/company_card.dart';
import 'package:test_eds_app/ui/widgets/user_widgets/user_contact_info.dart';

import '../../../data/models/user_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  // id for request check and update local date
  final int id;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UsersRepository repository = UsersRepository();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: repository.getUser(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data!.username),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    UserContactInfo(user: snapshot.data!),
                    CompanyCard(
                        item: snapshot.data!.company,
                        address: snapshot.data!.address),
                  ],
                ),
              ),
            );
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }
}
