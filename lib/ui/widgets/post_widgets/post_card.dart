import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/post_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.item, this.onTap}) : super(key: key);
  final Post item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        onTap: onTap,
        title: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          item.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
