import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/album_model.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({Key? key, required this.item, this.onTap}) : super(key: key);
  final Album item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.1, color: Theme.of(context).shadowColor)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: onTap,
        title: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
