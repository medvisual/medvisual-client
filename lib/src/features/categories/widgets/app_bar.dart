import 'package:flutter/material.dart';
import 'package:medvisual/src/features/categories/widgets/search_widget.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      title: Text(
        'Medvisual',
        style: theme.textTheme.titleLarge
            ?.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: theme.canvasColor,
          ),
        ),
      ],
      backgroundColor: theme.primaryColor,
      surfaceTintColor: Colors.transparent,
      pinned: true,
      floating: true,
      bottom: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: SearchWidget(),
      ),
    );
  }
}
