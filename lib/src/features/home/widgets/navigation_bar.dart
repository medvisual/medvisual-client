// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      selectedIndex: widget.currentIndex,
      indicatorColor: theme.primaryColor,
      destinations: [
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            'assets/icons/home.svg',
            colorFilter: ColorFilter.mode(theme.canvasColor, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            colorFilter:
                ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
          ),
          label: 'Категории',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('52'),
            child: SvgPicture.asset(
              'assets/icons/chat.svg',
              colorFilter: ColorFilter.mode(
                  theme.colorScheme.onSurface, BlendMode.srcIn),
            ),
          ),
          selectedIcon: Badge(
            label: const Text('52'),
            child: SvgPicture.asset(
              'assets/icons/chat.svg',
              colorFilter: ColorFilter.mode(theme.canvasColor, BlendMode.srcIn),
            ),
          ),
          label: 'Сообщения',
        ),
        NavigationDestination(
          icon: Badge(
            child: SvgPicture.asset(
              'assets/icons/profile.svg',
              colorFilter: ColorFilter.mode(
                  theme.colorScheme.onSurface, BlendMode.srcIn),
            ),
          ),
          selectedIcon: Badge(
            child: SvgPicture.asset(
              'assets/icons/profile.svg',
              colorFilter: ColorFilter.mode(
                  theme.colorScheme.onPrimary, BlendMode.srcIn),
            ),
          ),
          label: 'Профиль',
        ),
      ],
      onDestinationSelected: (index) {
        setState(() {
          AutoTabsRouter.of(context).setActiveIndex(index);
        });
      },
    );
  }
}
