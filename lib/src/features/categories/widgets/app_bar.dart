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
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: theme.colorScheme.onSurface),
      ),
      actions: const [
        SettingsButton(),
      ],
      centerTitle: true,
      backgroundColor: theme.colorScheme.surface,
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
