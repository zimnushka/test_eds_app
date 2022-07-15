import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/album_model.dart';
import 'package:test_eds_app/data/models/post_model.dart';
import 'package:test_eds_app/data/repositories/users_repository.dart';
import 'package:test_eds_app/ui/pages/album_pages/album_list_page.dart';
import 'package:test_eds_app/ui/pages/post_pages/post_list_page.dart';
import 'package:test_eds_app/ui/widgets/album_widget/album_card.dart';
import 'package:test_eds_app/ui/widgets/post_widgets/post_card.dart';
import 'package:test_eds_app/ui/widgets/user_widgets/company_card.dart';
import 'package:test_eds_app/ui/widgets/user_widgets/user_contact_info.dart';

import '../../../data/models/user_model.dart';
import '../album_pages/album_page.dart';
import '../post_pages/post_page.dart';

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
              item: widget.user.company,
              address: widget.user.address,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Posts"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return PostsListPage(userId: widget.user.id);
                          },
                        ),
                      );
                    },
                    child: const Text("more"),
                  ),
                ],
              ),
              subtitle: FutureBuilder<List<Post>>(
                  future: repository.getUserPosts(widget.user.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return CarouselSlider(
                          options: CarouselOptions(
                              height: 100,
                              aspectRatio:
                                  MediaQuery.of(context).size.width / 100),
                          items: snapshot.data!
                              .getRange(
                                  0,
                                  snapshot.data!.length > 1
                                      ? 2
                                      : snapshot.data!.length)
                              .map(
                                (e) => PostCard(
                                  item: e,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PostPage(post: e);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList());
                    }
                    return LinearProgressIndicator();
                  }),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Albums"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AlbumsListPage(userId: widget.user.id);
                          },
                        ),
                      );
                    },
                    child: const Text("more"),
                  ),
                ],
              ),
              subtitle: FutureBuilder<List<Album>>(
                  future: repository.getUserAlbums(widget.user.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CarouselSlider(
                          options: CarouselOptions(
                              height: 100,
                              aspectRatio:
                                  MediaQuery.of(context).size.width / 100),
                          items: snapshot.data!
                              .getRange(
                                  0,
                                  snapshot.data!.length > 1
                                      ? 2
                                      : snapshot.data!.length)
                              .map((e) => AlbumCard(
                                    item: e,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return AlbumPage(albom: e);
                                          },
                                        ),
                                      );
                                    },
                                  ))
                              .toList());
                    }
                    return LinearProgressIndicator();
                  }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
