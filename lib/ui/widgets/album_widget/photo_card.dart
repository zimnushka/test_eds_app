import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      leading: SizedBox(
          height: 50,
          width: 50,
          child: CachedNetworkImage(imageUrl: photo.thumbnailUrl)),
      title: Text(photo.title),
    );
  }
}
