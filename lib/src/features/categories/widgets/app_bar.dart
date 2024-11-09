import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/ui/widgets/search_widget.dart';
import 'package:medvisual/src/features/categories/widgets/settings_button.dart';
import 'package:medvisual/src/router/router.dart';

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
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: GestureDetector(
          child: Hero(
              tag: 'search-widget',
              child: SearchWidget(
                child: Text('Поиск',
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: theme.hintColor.withOpacity(0.7))),
              )),
          onTap: () {
            debugPrint('Search Widget was clicked');
            AutoRouter.of(context).navigate(const SearchRoute());
          },
        ),
      ),
    );
  }
}
