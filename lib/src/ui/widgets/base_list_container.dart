import 'package:flutter/material.dart';

class BaseListContainer extends StatelessWidget {
  const BaseListContainer({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
            color: theme.primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          text,
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
