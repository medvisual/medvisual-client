import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/ui/widgets/widgets.dart';

class ImagesViewWidget extends StatelessWidget {
  ImagesViewWidget({
    super.key,
  });

  final List<Widget> items = [
    Image.network(
        'https://prod-images-static.radiopaedia.org/images/1371188/0a1f5edc85aa58d5780928cb39b08659c1fc4d6d7c7dce2f8db1d63c7c737234_big_gallery.jpeg'),
    Image.network(
        'https://www.itnonline.com/sites/default/files/GettyImages-115203637.jpg'),
    Image.network(
        'https://introductiontoradiology.net/courses/rad/cxr/web%20images/rml-pneumonia-pa1b.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: SizedBox(
        height: 200,
        child: CarouselView(
          itemExtent: MediaQuery.of(context).size.width * 0.6,
          children: items.map((widget) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(20), child: widget);
          }).toList(),
        ),
      ),
    );
  }
}
