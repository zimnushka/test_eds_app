import 'package:flutter/material.dart';

import '../../../data/models/post_model.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text(widget.post.title),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(widget.post.body),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
