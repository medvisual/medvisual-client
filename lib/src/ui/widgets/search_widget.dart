import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    this.radius,
    this.height,
    this.inset,
    required this.child,
  });
  final double? radius;
  final double? height;
  final double? inset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: height ?? 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 30),
        color: theme.colorScheme.surfaceContainer,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.search,
            color: theme.hintColor.withOpacity(0.7),
          ),
          SizedBox(width: inset ?? 10),
          child
        ],
      ),
    );
  }
}
