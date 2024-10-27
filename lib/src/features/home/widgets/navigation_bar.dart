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
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: widget.currentIndex,
      indicatorColor: theme.colorScheme.surface,
      backgroundColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(theme.colorScheme.onSurface),
      animationDuration: const Duration(milliseconds: 350),
      destinations: const [
        NavBarItem(
          iconName: 'home',
          label: 'Категории',
        ),
        NavBarItem(
          iconName: 'chat',
          label: 'Сообщения',
          inBadge: true,
          badgeText: '52',
        ),
        NavBarItem(
          iconName: 'profile',
          label: 'Профиль',
        )
      ],
      onDestinationSelected: (index) {
        setState(() {
          AutoTabsRouter.of(context).setActiveIndex(index);
        });
      },
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem(
      {super.key,
      required this.iconName,
      this.label,
      this.inBadge = false,
      this.badgeText})
      : assert(badgeText == null || inBadge == true,
            'If badgeText is provided, inBadge must be true'),
        assert(badgeText != null || inBadge == false,
            'If inBadge is true, badgeText must be provided');

  final String iconName;
  final String? label;
  final bool? inBadge;
  final String? badgeText;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NavigationDestination(
      icon: inBadge == true
          ? Badge(
              label: Text(badgeText!),
              child: SvgPicture.asset(
                'assets/icons/$iconName.svg',
                colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface, BlendMode.srcIn),
              ),
            )
          : SvgPicture.asset(
              'assets/icons/$iconName.svg',
              colorFilter: ColorFilter.mode(
                  theme.colorScheme.onSurface, BlendMode.srcIn),
            ),
      label: label != null ? label! : '',
    );
  }
}
