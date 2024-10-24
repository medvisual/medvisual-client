import 'package:flutter/material.dart';
import 'package:medvisual/src/features/categories/widgets/search_widget.dart';
import 'package:medvisual/src/features/categories/widgets/settings_button.dart';

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
        style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
      ),
      actions: const [
        SettingsButton(),
      ],
      backgroundColor: theme.canvasColor,
      surfaceTintColor: Colors.transparent,
      pinned: false,
      floating: false,
      stretch: false,
      bottom: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: SearchWidget(),
      ),
    );
  }
}
