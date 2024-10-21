// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CurvedNavigationBar(
        backgroundColor: theme.canvasColor,
        items: [
          Icon(
            Icons.home_rounded,
            size: 30,
            color:
                widget.currentIndex == 0 ? theme.primaryColor : theme.hintColor,
          ),
          Icon(
            Icons.message_rounded,
            size: 30,
            color:
                widget.currentIndex == 1 ? theme.primaryColor : theme.hintColor,
          ),
          Icon(
            Icons.person_rounded,
            size: 30,
            color:
                widget.currentIndex == 2 ? theme.primaryColor : theme.hintColor,
          ),
        ],
        buttonBackgroundColor: theme.canvasColor,
        height: 75,
        onTap: (index) {
          setState(() {
            AutoTabsRouter.of(context).setActiveIndex(index);
          });
        });
  }
}
