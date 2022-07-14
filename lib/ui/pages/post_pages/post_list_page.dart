import 'package:flutter/material.dart';
import 'package:test_eds_app/ui/pages/Post_pages/post_page.dart';

import '../../../data/models/post_model.dart';
import '../../../data/repositories/posts_repository.dart';
import '../../widgets/post_widgets/post_card.dart';

class PostsListPage extends StatefulWidget {
  const PostsListPage({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  State<PostsListPage> createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {
  final PostsRepository repository = PostsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Post>>(
          future: repository.getPosts(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      item: snapshot.data![index],
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PostPage(post: snapshot.data![index]);
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
