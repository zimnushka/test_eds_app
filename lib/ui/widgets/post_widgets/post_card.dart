import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/post_model.dart';
import 'package:test_eds_app/ui/pages/post_pages/post_page.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.item}) : super(key: key);
  final Post item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.1, color: Theme.of(context).shadowColor),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PostPage(post: item);
              },
            ),
          );
        },
        title: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            item.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
