import 'package:flutter/material.dart';

class StackNavigationBar extends StatefulWidget {
  const StackNavigationBar(
      {super.key, required this.selectedIndex, required this.onSelected});
  final int selectedIndex;
  final VoidCallback onSelected;

  @override
  State<StackNavigationBar> createState() => _StackNavigationBarState();
}

class _StackNavigationBarState extends State<StackNavigationBar> {
  final double horizontal_margin = 40;

  @override
  Widget build(BuildContext context) {
    final int index = 0;
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: theme.primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: horizontal_margin),
              child: Icon(
                Icons.home,
                color: widget.selectedIndex == 0
                    ? theme.canvasColor
                    : theme.hintColor,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: horizontal_margin),
              child: IconButton(
                onPressed: widget.onSelected,
                icon: Icon(
                  Icons.message,
                  color: widget.selectedIndex == 1
                      ? theme.canvasColor
                      : theme.hintColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: horizontal_margin),
              child: Icon(
                Icons.person_4,
                color: widget.selectedIndex == 2
                    ? theme.canvasColor
                    : theme.hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
