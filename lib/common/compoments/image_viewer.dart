import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../utils.dart';

/**
 * image_viewer
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/27/21.
 */
class ImageViewer extends StatelessWidget {
  final FileImage image;

  ImageViewer({@required this.image});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 300,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image(
              image: image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      onTap: () async {
        Size size = await getImageSizeFit(context, image.file);
        await showDialog(
          context: context,
          builder: (builder) => Dialog(
            backgroundColor: Colors.transparent,
            // child: Text('hi')
            child: Container(
                height: size.height,
                width: size.width,
                child: PhotoView(
                  backgroundDecoration:
                      BoxDecoration(color: Colors.transparent),
                  imageProvider: image,
                )),
          ),
        );
      },
    );
  }
}
