import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/home/widgets/stack_navigation_bar.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0), // Blur effect
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          height: MediaQuery.of(context).size.height * 0.09,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withAlpha(178),
          ),
          child: StackNavigationBar(
            selectedIndex: currentIndex,
            onSelected: (index) {
              AutoTabsRouter.of(context).setActiveIndex(index);
            },
            icons: [
              _widgetFromIconData(
                  iconData: Icons.category, index: 0, theme: theme),
              Image.asset(
                'assets/icons/chat.png',
                height: 28,
                width: 28,
                color: currentIndex == 1
                    ? theme.colorScheme.onSurface
                    : theme.hintColor.withAlpha(120),
              ),
              _widgetFromIconData(
                  iconData: Icons.person, index: 2, theme: theme),
            ],
          ),
        ),
      ),
    );
  }

  Icon _widgetFromIconData(
      {required IconData iconData,
      required int index,
      required ThemeData theme}) {
    return Icon(
      iconData,
      size: 28,
      color: currentIndex == index
          ? theme.colorScheme.onSurface
          : theme.hintColor.withAlpha(120),
    );
  }
}
