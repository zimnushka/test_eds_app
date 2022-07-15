import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_eds_app/data/models/comment_model.dart';
import 'package:test_eds_app/data/repositories/comments_repository.dart';
import 'package:test_eds_app/ui/widgets/comment_widgets/comment_card.dart';
import 'package:test_eds_app/ui/widgets/comment_widgets/comment_editor.dart';

import '../../../data/models/post_model.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final CommentsRepository repository = CommentsRepository();
  Box<Comment>? commentsBox;

  void addComment() async {
    await showModalBottomSheet(
        backgroundColor: Theme.of(context).cardColor,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return CommentEditor(
            postId: widget.post.id,
          );
        });
  }

  Future<List<Comment>> load() async {
    if (!Hive.isAdapterRegistered(CommentAdapter().typeId)) {
      Hive.registerAdapter(CommentAdapter());
    }
    if (commentsBox == null || commentsBox?.isOpen != true) {
      commentsBox = await Hive.openBox<Comment>('comment');
    }

    List<Comment> comments = commentsBox!.values
        .where((element) => element.postId == widget.post.id)
        .toList();
    if (comments.isEmpty) {
      comments = (await repository.getComments(widget.post.id)).data;
      commentsBox!.addAll(comments);
    } else {
      //FOR update local storage
      repository.getComments(widget.post.id).then((value) {
        if (value.isSuccesful == true) {
          if (!mounted) return;

          commentsBox!.clear();
          commentsBox!.addAll(comments
                  .where((element) => element.postId != widget.post.id)
                  .toList() +
              value.data);
        }
      });
    }
    return comments;
  }

  @override
  void dispose() {
    commentsBox?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).cardColor,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(widget.post.title),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(widget.post.body),
                ),
              ),
            ),
          ),
          FutureBuilder<List<Comment>>(
              future: load(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return CommentCard(comment: snapshot.data![index]);
                      },
                      childCount: snapshot.data!.length,
                    ),
                  );
                }
                return SliverToBoxAdapter(child: LinearProgressIndicator());
              })
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: addComment, child: Icon(Icons.chat)),
    );
  }
}
