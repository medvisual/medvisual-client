import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComtainer extends StatelessWidget {
  const ShimmerComtainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final random = Random();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(
          right: (random.nextInt(200) + 50).toDouble(), left: 20),
      height: MediaQuery.of(context).size.height * 0.03,
      child: Shimmer.fromColors(
        baseColor: theme.colorScheme.surfaceContainer.withOpacity(0.3),
        highlightColor: theme.colorScheme.surfaceContainerHigh.withOpacity(0.3),
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.canvasColor,
          ),
        ),
      ),
    );
  }
}
