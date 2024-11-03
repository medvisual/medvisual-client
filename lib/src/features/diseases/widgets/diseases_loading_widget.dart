import 'package:flutter/material.dart';
import 'package:medvisual/src/features/diseases/widgets/widgets.dart';

class DiseasesLoadingWidget extends StatelessWidget {
  const DiseasesLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // or this
      // child: LoadingAnimationWidget.stretchedDots(
      //   color: theme.primaryColor,
      //   size: 60,
      // ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return const ShimmerComtainer();
      },
    );
  }
}
