import 'package:flutter/material.dart';

class SettingCategoryWidget extends StatelessWidget {
  const SettingCategoryWidget(
      {super.key,
      required this.onCategoryWidgets,
      this.categoryTitle,
      this.inContainer = false});

  final List<Widget> onCategoryWidgets;
  final String? categoryTitle;
  final bool inContainer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      color:
          inContainer ? theme.colorScheme.surfaceContainer : Colors.transparent,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              categoryTitle ?? '',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(onCategoryWidgets.length, (index) {
            return Align(
                alignment: Alignment.center, child: onCategoryWidgets[index]);
          })
        ],
      ),
    );
  }
}
