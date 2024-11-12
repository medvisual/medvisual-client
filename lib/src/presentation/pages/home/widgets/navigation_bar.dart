import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/pages/home/widgets/stack_navigation_bar.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(0), // Закругление углов
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0), // Эффект размытия
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          height: MediaQuery.of(context).size.height * 0.09,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.7),
          ),
          child: StackNavigationBar(
            selectedIndex: currentIndex,
            onSelected: (index) {
              AutoTabsRouter.of(context).setActiveIndex(index);
            },
            items: const [
              Icons.category,
              Icons.all_inbox,
              Icons.face,
            ],
          ),
        ),
      ),
    );
  }
}
