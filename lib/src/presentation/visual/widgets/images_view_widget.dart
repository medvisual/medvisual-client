import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImagesViewWidget extends StatelessWidget {
  ImagesViewWidget({
    super.key,
  });

  final List<String> imagesLinks = [
    'https://prod-images-static.radiopaedia.org/images/1371188/0a1f5edc85aa58d5780928cb39b08659c1fc4d6d7c7dce2f8db1d63c7c737234_big_gallery.jpeg',
    'https://www.itnonline.com/sites/default/files/GettyImages-115203637.jpg',
    'https://introductiontoradiology.net/courses/rad/cxr/web%20images/rml-pneumonia-pa1b.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselSlider.builder(
        itemCount: imagesLinks.length,
        itemBuilder: (context, index, realIndex) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imagesLinks[index],
                fit: BoxFit.cover,
              ));
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.6,
          aspectRatio: 2.0,
        ),
      ),
    );
  }
}
