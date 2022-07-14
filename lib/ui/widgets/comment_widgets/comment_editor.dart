import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/comment_model.dart';
import 'package:test_eds_app/data/repositories/comments_repository.dart';
import 'package:test_eds_app/data/repositories/repository.dart';

class CommentEditor extends StatefulWidget {
  const CommentEditor({Key? key, required this.postId}) : super(key: key);
  final int postId;

  @override
  State<CommentEditor> createState() => _CommentEditorState();
}

class _CommentEditorState extends State<CommentEditor> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  ResponseData? message;

  bool load = false;

  send() async {
    if (load) return;
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        bodyController.text.isEmpty) {
      message = const ResponseData(data: "Empty field", isSuccesful: false);
      setState(() {});
      return;
    }
    message = null;
    load = true;
    setState(() {});
    final _comment = await CommentsRepository().sendComment(Comment(
        body: bodyController.text,
        email: emailController.text,
        id: -1,
        name: nameController.text,
        postId: widget.postId));
    if (_comment != null) {}
    load = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: emailController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Email"),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 150),
              child: TextField(
                controller: bodyController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                decoration: InputDecoration(hintText: "Comment..."),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                onPressed: send,
                child: Text("Send"))
          ],
        ),
      ),
    );
  }
}
