import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/photo_model.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({Key? key, required this.photo, this.onTap})
      : super(key: key);
  final Photo photo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(photo.thumbnailUrl),
      title: Text(photo.title),
    );
  }
}
