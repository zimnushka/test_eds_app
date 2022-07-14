import 'package:flutter/material.dart';
import 'package:test_eds_app/data/repositories/users_repository.dart';
import 'package:test_eds_app/ui/pages/post_pages/post_list_page.dart';
import 'package:test_eds_app/ui/widgets/user_widgets/company_card.dart';
import 'package:test_eds_app/ui/widgets/user_widgets/user_contact_info.dart';

import '../../../data/models/user_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  // id for request check and update local date
  final User user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UsersRepository repository = UsersRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserContactInfo(user: widget.user),
            CompanyCard(
                item: widget.user.company, address: widget.user.address,),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PostsListPage(userId: widget.user.id);
                  },),);
                },
                child: const Text("POSTS"),)
          ],
        ),
      ),
    );
  }
}
