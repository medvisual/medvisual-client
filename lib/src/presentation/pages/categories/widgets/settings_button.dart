import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: IconButton(
        onPressed: () {
          AutoTabsRouter.of(context).navigateNamed('/settings');
        },
        icon: SvgPicture.asset(
          'assets/icons/settings.svg',
          colorFilter:
              ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
        ),
        color: theme.hintColor.withOpacity(0.5),
      ),
    );
  }
}
