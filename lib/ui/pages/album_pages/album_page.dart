import 'package:flutter/material.dart';
import 'package:test_eds_app/data/models/album_model.dart';
import 'package:test_eds_app/data/models/photo_model.dart';
import 'package:test_eds_app/data/repositories/albums_repository.dart';
import 'package:test_eds_app/ui/widgets/album_widget/photo_card.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key, required this.albom}) : super(key: key);
  final Album albom;

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final AlbumsRepository repository = AlbumsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.albom.title),
      ),
      body: FutureBuilder<List<Photo>>(
          future: repository.getAlbum(widget.albom.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    maxCrossAxisExtent: 600,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return PhotoCard(photo: snapshot.data![index]);
                  });
            }
            return LinearProgressIndicator();
          }),
    );
  }
}
