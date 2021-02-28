import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_app/common/compoments/image_viewer.dart';
import 'package:photo_view/photo_view.dart';

/**
 * image_slider
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/28/21.
 */
class ImageSlider extends StatelessWidget {
  final List<FileImage> images;
  final double height;
  final double width;

  CarouselController buttonCarouselController = CarouselController();

  ImageSlider(
    this.images, {
    this.height = 400,
    this.width = 500,
  });

  Widget _buildItem(context, index) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            image: DecorationImage(
              image: images[index],
              fit: BoxFit.cover,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Swiper(
        onTap: (index) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => ImageViewer(
                        images,
                        initialIndex: index,
                      )));
        },
        itemBuilder: _buildItem,
        // Image(image: FileImage(widget.todo.images[index]), fit: BoxFit.fill),
        itemCount: images.length,
        itemWidth: width,
        itemHeight: height,
        pagination: new SwiperPagination(),
        // control: new SwiperControl(),
        // viewportFraction: 0.8,
        // scale: 0.5,
        // fade: 0.5,
        layout: SwiperLayout.TINDER,
      ),
    );
  }
}
