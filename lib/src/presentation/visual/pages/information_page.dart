import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/visual/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart'; // Provides 'router' extension

class InformationPage extends StatelessWidget {
  const InformationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const ImagesViewWidget()),
            const DiseaseInformationWidget(),
            const SizedBox(height: 20),
            DeleteButton(onResult: () {
              context.router.popForced();
            })
          ],
        ),
      ),
    );
  }
}
