import 'package:flutter/material.dart';

class OnCategoryWidget extends StatelessWidget {
  const OnCategoryWidget({
    super.key,
    required this.leftWidget,
    required this.rightWidget,
  });

  final Widget leftWidget;
  final Widget rightWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [leftWidget, rightWidget],
      ),
    );
  }
}
