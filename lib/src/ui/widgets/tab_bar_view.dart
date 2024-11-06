import 'package:flutter/material.dart';

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({
    super.key,
    required this.categoryList,
    required this.pageController,
  });

  final List<TabBarItem> categoryList;
  final PageController pageController;

  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Listen to page changes to update the selected tab
    widget.pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_onPageChanged);
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      _selectedIndex = widget.pageController.page?.round() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.categoryList.length,
          (index) => CategoryCard(
            category: widget.categoryList[index],
            isSelected: index == _selectedIndex, // Pass isSelected directly
            onPressed: () {
              // Update the selected index and animate the page view
              widget.pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
        ),
      ),
    );
  }
}

class TabBarItem {
  final String title;
  // Removed isSelected from here as it's now managed by the parent widget

  TabBarItem(this.title);
}

class CategoryCard extends StatelessWidget {
  final TabBarItem category;
  final bool isSelected; // Added isSelected property
  final VoidCallback onPressed;

  const CategoryCard({
    required this.category,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isSelected // Use the isSelected property here
            ? theme.primaryColor
            : theme.colorScheme.surfaceContainer,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: TextButton(
          style: const ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          onPressed: onPressed,
          child: Text(
            category.title,
            style: TextStyle(
              color: isSelected // Use the isSelected property here
                  ? Colors.white
                  : theme.hintColor,
            ),
          ),
        ),
      ),
    );
  }
}
