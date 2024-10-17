import 'package:flutter/material.dart';

class BaseListContainer extends StatelessWidget {
  const BaseListContainer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
          color: theme.primaryColor, borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: Text(
        'Отделение',
        style:
            theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      )),
    );
  }
}
