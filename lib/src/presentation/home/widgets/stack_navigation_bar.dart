import 'package:flutter/material.dart';

class StackNavigationBar extends StatelessWidget {
  const StackNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.icons,
  }) : assert(icons.length >= 2);

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final List<Widget> icons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Calculate horizontal margins
    final double horizontalMargin =
        ((MediaQuery.of(context).size.width - 48) - (icons.length * 28)) /
            (icons.length * 2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
        icons.length,
        (index) => _buildNavItem(
          icon: icons[index],
          index: index,
          theme: theme,
          horizontalMargin: horizontalMargin,
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required Widget icon,
    required int index,
    required ThemeData theme,
    required double horizontalMargin,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: InkWell(
        onTap: () => onSelected(index),
        child: Padding(padding: const EdgeInsets.all(8.0), child: icon),
      ),
    );
  }
}
