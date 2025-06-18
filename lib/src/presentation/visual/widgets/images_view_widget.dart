import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImagesViewWidget extends StatefulWidget {
  // Изменили на StatefulWidget
  const ImagesViewWidget({
    super.key,
  });

  @override
  State<ImagesViewWidget> createState() => _ImagesViewWidgetState();
}

class _ImagesViewWidgetState extends State<ImagesViewWidget> {
  final List<String> imagesLinks = [
    'https://prod-images-static.radiopaedia.org/images/1371188/0a1f5edc85aa58d5780928cb39b08659c1fc4d6d7c7dce2f8db1d63c7c737234_big_gallery.jpeg',
    'https://www.itnonline.com/sites/default/files/GettyImages-115203637.jpg',
    'https://introductiontoradiology.net/courses/rad/cxr/web%20images/rml-pneumonia-pa1b.jpg'
  ];

  @override
  void initState() {
    super.initState();
    // Предварительная загрузка изображений
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var link in imagesLinks) {
        precacheImage(
          NetworkImage(link),
          context,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 200,
      child: CarouselSlider.builder(
        itemCount: imagesLinks.length,
        itemBuilder: (context, index, realIndex) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imagesLinks[index],
                loadingBuilder: (context, child, loadingProgress) {
                  // Если изображение УЖЕ ЗАГРУЖЕНО (т.е. loadingProgress == null),
                  // показываем его сразу. В противном случае - индикатор.
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: theme.colorScheme.surfaceContainer),
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/no_image_placeholder.jpg',
                    fit: BoxFit.cover,
                  );
                },
                fit: BoxFit.cover,
              ));
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.6,
          aspectRatio: 2.0,
          // Поэкспериментируйте с этими значениями:
          // Увеличьте autoPlayInterval, чтобы дать время на загрузку
          autoPlayInterval: const Duration(seconds: 4), // Например, 4 секунды
          // Увеличьте autoPlayAnimationDuration для более плавных переходов
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
      ),
    );
  }
}
