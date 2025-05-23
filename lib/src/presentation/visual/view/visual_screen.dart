import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/core/widgets/widgets.dart';
import 'package:medvisual/src/presentation/visual/pages/visual_disease_page.dart';
import 'package:medvisual/src/presentation/visual/pages/information_page.dart';
import 'package:medvisual/src/presentation/visual/widgets/disease_inherit_widget.dart';

@RoutePage()
class VisualScreen extends StatefulWidget {
  const VisualScreen(
      {super.key,
      required this.disease,
      required this.diseaseId,
      required this.category});
  final String category;
  final String disease;
  final int diseaseId;

  @override
  State<VisualScreen> createState() => _VisualScreenState();
}

class _VisualScreenState extends State<VisualScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return DiseaseInheritWidget(
      disease: widget.disease,
      diseaseId: widget.diseaseId,
      child: Scaffold(
          appBar: AppBar(
            title:
                FittedBox(fit: BoxFit.scaleDown, child: Text(widget.disease)),
            centerTitle: true,
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
          )),
    );
  }
}
