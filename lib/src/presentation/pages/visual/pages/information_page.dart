import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/ui/widgets/widgets.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ImagesViewWidget(),
        ),
        const DiseaseInformationWidget(),
      ],
    );
  }
}

class DiseaseInformationWidget extends StatelessWidget {
  const DiseaseInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BaseContainer(
      child: Text(
          'Пневмони́я, воспаление лёгких — воспаление лёгочной ткани обычно инфекционного происхождения с преимущественным поражением альвеол. Пневмонии, вызванные инфекциями, являются формой острой респираторной инфекции, затрагивающей лёгкие.'),
    );
  }
}

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
      child: CarouselSlider(
          items: items.map((widget) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(20), child: widget);
          }).toList(),
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.25,
              viewportFraction: 0.8,
              autoPlay: true)),
    );
  }
}
