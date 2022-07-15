import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  Box<Post>? postsBox;

  Future<List<Post>> load() async {
    if (!Hive.isAdapterRegistered(PostAdapter().typeId)) {
      Hive.registerAdapter(PostAdapter());
    }
    if (postsBox == null || postsBox?.isOpen != true) {
      postsBox = await Hive.openBox<Post>('post');
    }

    List<Post> posts = postsBox!.values
        .where((element) => element.userId == widget.userId)
        .toList();
    if (posts.isEmpty) {
      posts = (await repository.getPosts(widget.userId)).data;
      postsBox!.addAll(posts);
    } else {
      //FOR update local storage
      repository.getPosts(widget.userId).then((value) {
        if (value.isSuccesful == true) {
          if (!mounted) return;

          postsBox!.clear();
          postsBox!.addAll(posts
                  .where((element) => element.userId != widget.userId)
                  .toList() +
              value.data);
        }
      });
    }
    return posts;
  }

  @override
  void dispose() {
    postsBox?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Post>>(
        future: load(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return PostCard(
                  item: snapshot.data![index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return PostPage(post: snapshot.data![index]);
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
