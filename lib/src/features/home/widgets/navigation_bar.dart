// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
  });
  final int currentIndex;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
        currentIndex: widget.currentIndex,
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home_rounded, size: 30),
              icon: Icon(Icons.home_outlined, size: 30),
              label: 'Категории'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_outline_rounded, size: 30),
              activeIcon: Icon(Icons.star_rounded, size: 30),
              label: 'Избранное'),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.message_rounded, size: 30),
              icon: Icon(Icons.message_outlined, size: 30),
              label: 'Чаты'),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.person_rounded, size: 30),
              icon: Icon(Icons.person_outline_rounded, size: 30),
              label: 'Профиль'),
        ],
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.hintColor,
        onTap: (index) {
          setState(() {
            AutoTabsRouter.of(context).setActiveIndex(index);
          });
        });
  }
}
