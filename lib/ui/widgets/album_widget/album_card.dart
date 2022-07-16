import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/album_model.dart';
import 'package:test_eds_app/ui/pages/album_pages/album_page.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({Key? key, required this.item}) : super(key: key);
  final Album item;

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
                return AlbumPage(albom: item);
              },
            ),
          );
        },
        title: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
