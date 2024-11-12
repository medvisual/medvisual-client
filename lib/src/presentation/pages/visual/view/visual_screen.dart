import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/pages/visual/pages/visual_disease_page.dart';
import 'package:medvisual/src/presentation/pages/visual/pages/information_page.dart';
import 'package:medvisual/src/presentation/ui/widgets/widgets.dart';

class VisualScreen extends StatefulWidget {
  const VisualScreen({super.key, required this.disease});
  final String disease;

  @override
  State<VisualScreen> createState() => _VisualScreenState();
}

class _VisualScreenState extends State<VisualScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FittedBox(fit: BoxFit.scaleDown, child: Text(widget.disease)),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 70),
              child:
                  CustomTabBarView(pageController: controller, categoryList: [
                TabBarItem("Информация"),
                TabBarItem("Создать Visual"),
              ])),
        ),
        body: PageView(
          controller: controller,
          children: [
            const InformationPage(),
            ImagePickerPage(disease: widget.disease)
          ],
        ));
  }
}
