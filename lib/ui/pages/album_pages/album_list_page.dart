import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  Box<Album>? albumsBox;

  Future<List<Album>> load() async {
    if (!Hive.isAdapterRegistered(AlbumAdapter().typeId)) {
      Hive.registerAdapter(AlbumAdapter());
    }
    if (albumsBox == null || albumsBox?.isOpen != true) {
      albumsBox = await Hive.openBox<Album>('album');
    }

    List<Album> albums = albumsBox!.values
        .where((element) => element.userId == widget.userId)
        .toList();
    if (albums.isEmpty) {
      albums = (await repository.getAlbums(widget.userId)).data;
      albumsBox!.addAll(albums);
    } else {
      //FOR update local storage
      repository.getAlbums(widget.userId).then((value) {
        if (value.isSuccesful == true) {
          if (!mounted) return;

          albumsBox!.clear();
          albumsBox!.addAll(albums
                  .where((element) => element.userId != widget.userId)
                  .toList() +
              value.data);
        }
      });
    }
    return albums;
  }

  @override
  void dispose() {
    albumsBox?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Album>>(
        future: load(),
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
