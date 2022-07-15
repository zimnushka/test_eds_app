import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:test_eds_app/data/models/photo_model.dart';

class ImageViewPage extends StatefulWidget {
  const ImageViewPage({Key? key, required this.images, required this.index})
      : super(key: key);

  final List<Photo> images;
  final int index;
  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  late final PageController controller =
      PageController(initialPage: widget.index);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            pageController: controller,
            itemCount: widget.images.length,
            builder: (context, index) {
              return widget.images[index].localUrl != null
                  ? PhotoViewGalleryPageOptions(
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered,
                      imageProvider:
                          FileImage(File(widget.images[index].localUrl!)),
                    )
                  : PhotoViewGalleryPageOptions(
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered,
                      imageProvider: NetworkImage(widget.images[index].url),
                    );
            },
          ),
          Positioned(
            top: 10,
            left: 10,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white70,
                primary: Colors.black,
                shape: const CircleBorder(),
                fixedSize: const Size(40, 40),
              ),
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
