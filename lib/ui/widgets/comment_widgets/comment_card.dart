import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/comment_model.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key, required this.comment}) : super(key: key);
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(width: 0.1, color: Theme.of(context).shadowColor),),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(comment.name),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 8),
              child: Text(comment.body),
            ),
          ),
          Text(comment.email),
        ],
      ),
    );
  }
}
