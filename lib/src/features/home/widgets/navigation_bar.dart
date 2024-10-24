// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
    // TODO: Delete comment code
    // return BottomNavigationBar(
    //     currentIndex: widget.currentIndex,
    //     backgroundColor: theme.canvasColor,
    //     items: [
    //       BottomNavigationBarItem(
    // icon: Icon(
    //   Icons.home_rounded,
    //   size: 30,
    //   color: widget.currentIndex == 0
    //       ? theme.primaryColor
    //       : theme.hintColor,
    // ),
    //           label: 'Категории'),
    //       BottomNavigationBarItem(
    //           icon: Icon(
    //             Icons.message_rounded,
    //             size: 30,
    //             color: widget.currentIndex == 1
    //                 ? theme.primaryColor
    //                 : theme.hintColor,
    //           ),
    //           label: 'Чаты'),
    //       BottomNavigationBarItem(
    //           icon: Icon(
    //             Icons.person_rounded,
    //             size: 30,
    //             color: widget.currentIndex == 2
    //                 ? theme.primaryColor
    //                 : theme.hintColor,
    //           ),
    //           label: 'Профиль')
    //     ],
    //     onTap: (index) {
    //       setState(() {
    //         AutoTabsRouter.of(context).setActiveIndex(index);
    //       });
    //     });
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: widget.currentIndex,
      indicatorColor: theme.primaryColor,
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(
            Icons.home_outlined,
            color: theme.canvasColor,
          ),
          icon: const Icon(
            Icons.home_rounded,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: const Badge(
            label: Text('52'),
            child: Icon(Icons.messenger_sharp),
          ),
          selectedIcon: Badge(
            label: const Text('52'),
            child:
                Icon(Icons.messenger_outline_rounded, color: theme.canvasColor),
          ),
          label: 'Messages',
        ),
        NavigationDestination(
          icon: const Badge(child: Icon(Icons.person_rounded)),
          selectedIcon: Badge(
              child: Icon(
            Icons.person_outline_rounded,
            color: theme.canvasColor,
          )),
          label: 'Profile',
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
