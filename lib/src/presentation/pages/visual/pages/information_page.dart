import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/pages/visual/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart'; // Provides 'router' extension

class InformationPage extends StatelessWidget {
  const InformationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImagesViewWidget(),
        const DiseaseInformationWidget(),
        const SizedBox(height: 20),
        DeleteButton(onResult: () {
          context.router.popForced();
        })
      ],
    );
  }
}
