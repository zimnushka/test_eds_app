import 'package:flutter/material.dart';
import 'package:test_eds_app/ui/pages/album_pages/album_page.dart';

import '../../../data/models/album_model.dart';
import '../../../data/repositories/albums_repository.dart';
import '../../widgets/album_widget/album_card.dart';

class AlbumsListPage extends StatefulWidget {
  const AlbumsListPage({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  State<AlbumsListPage> createState() => _AlbumsListPageState();
}

class _AlbumsListPageState extends State<AlbumsListPage> {
  final AlbumsRepository repository = AlbumsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Album>>(
        future: repository.getAlbums(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return AlbumCard(
                  item: snapshot.data![index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AlbumPage(albom: snapshot.data![index]);
                        },
                      ),
                    );
                  },
                );
              },
            );
          }
          return const LinearProgressIndicator();
        },
      ),
    );
  }
}
