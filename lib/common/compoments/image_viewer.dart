import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../utils.dart';

/**
 * image_viewer
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/27/21.
 */

class ImageViewer extends StatefulWidget {
  final List<FileImage> images;
  final int initialIndex;
  final double sensitivity;
  final PageController pageController;

  ImageViewer(this.images, {this.initialIndex = 0, this.sensitivity = 1})
      : pageController = PageController(initialPage: initialIndex);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentIndex = widget.initialIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   title: Text("(${currentIndex + 1}/${widget.images.length})"),
        // ),
        body: Container(
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: BoxDecoration(color: Colors.transparent),
                itemCount: widget.images.length,
                builder: _buildItem,
                loadingBuilder: _buildLoading,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "${currentIndex + 1} / ${widget.images.length}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    decoration: null,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildLoading(context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          ),
        ),
      );

  PhotoViewGalleryPageOptions _buildItem(context, index) {
    return PhotoViewGalleryPageOptions(
      imageProvider: widget.images[index],
      minScale: PhotoViewComputedScale.contained,
      // initialScale: PhotoViewComputedScale.contained * 0.8,
      heroAttributes:
          PhotoViewHeroAttributes(tag: widget.images[index].file.path),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
