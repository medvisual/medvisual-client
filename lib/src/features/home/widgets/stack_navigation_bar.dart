import 'package:flutter/material.dart';

class StackNavigationBar extends StatelessWidget {
  const StackNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.items,
    this.iconSize = 28,
  }) : assert(items.length >= 2);

  final int selectedIndex;
  final double iconSize;
  final ValueChanged<int> onSelected;
  final List<IconData> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Calculate horizontal margins
    final double horizontalMargin =
        ((MediaQuery.of(context).size.width - 48) - (items.length * iconSize)) /
            (items.length * 2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
        items.length,
        (index) => _buildNavItem(
          icon: items[index],
          index: index,
          theme: theme,
          horizontalMargin: horizontalMargin,
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required ThemeData theme,
    required double horizontalMargin,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: InkWell(
        onTap: () => onSelected(index),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: iconSize,
            color: selectedIndex == index
                ? theme.colorScheme.onSurface
                : theme.hintColor.withAlpha(120),
          ),
        ),
      ),
    );
  }
}
