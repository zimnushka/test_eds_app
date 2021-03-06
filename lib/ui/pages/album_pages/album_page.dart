import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_eds_app/data/models/album_model.dart';
import 'package:test_eds_app/data/models/photo_model.dart';
import 'package:test_eds_app/data/repositories/albums_repository.dart';
import 'package:test_eds_app/ui/widgets/album_widget/photo_card.dart';

import '../../widgets/album_widget/image_viever.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key, required this.albom}) : super(key: key);
  final Album albom;

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final AlbumsRepository repository = AlbumsRepository();
  Box<Photo>? photosBox;

  // Future<String> savePhoto(
  //   String path,
  //   String url, {
  //   bool isThumbnai = false,
  // }) async {
  //   var responseUrl = await http.get(Uri.parse(url));
  //   File fileUrl =
  //       File('$path/${url.split("/").last}${isThumbnai ? "thumbnai" : ""}');
  //   fileUrl.writeAsBytesSync(responseUrl.bodyBytes);
  //   return '$path/${url.split("/").last}${isThumbnai ? "thumbnai" : ""}';
  // }

  Future<List<Photo>> load() async {
    if (!Hive.isAdapterRegistered(PhotoAdapter().typeId)) {
      Hive.registerAdapter(PhotoAdapter());
    }
    if (photosBox == null || photosBox?.isOpen != true) {
      photosBox = await Hive.openBox<Photo>('photo');
    }

    List<Photo> photos = photosBox!.values
        .where((element) => element.albumId == widget.albom.id)
        .toList();
    if (photos.isEmpty) {
      photos = (await repository.getAlbum(widget.albom.id)).data;
      // final directory = await getApplicationDocumentsDirectory();
      // for (var element in photos) {
      //   element.localUrl = await savePhoto(directory.path, element.url);
      //   element.loaclThumbnailUrl = await savePhoto(
      //     directory.path,
      //     element.thumbnailUrl,
      //     isThumbnai: true,
      //   );
      // }

      photosBox!.addAll(photos);
    } else {
      //FOR update local storage
      repository.getAlbum(widget.albom.id).then((value) {
        if (value.isSuccesful == true) {
          if (!mounted) return;

          photosBox!.clear();
          photosBox!.addAll(
            photos
                    .where((element) => element.albumId != widget.albom.id)
                    .toList() +
                value.data,
          );
        }
      });
    }
    return photos;
  }

  @override
  void dispose() {
    photosBox?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.albom.title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: load(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return PhotoCard(
                  photo: snapshot.data![index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ImageViewPage(
                            images: snapshot.data!,
                            index: index,
                          );
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
