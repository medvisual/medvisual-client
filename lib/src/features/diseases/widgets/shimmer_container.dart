import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComtainer extends StatelessWidget {
  const ShimmerComtainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.all(2),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: theme.canvasColor,
          ),
        ),
      ),
    );
  }
}
