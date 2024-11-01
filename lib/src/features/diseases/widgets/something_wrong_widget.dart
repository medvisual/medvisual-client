import 'package:flutter/material.dart';

class SomethingWrongWidget extends StatelessWidget {
  const SomethingWrongWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Что-то пошло не так...',
            style: theme.textTheme.titleLarge
                ?.copyWith(color: theme.colorScheme.onSurface),
          ),
          Text(
            'Пожалуйста попробуйте позже',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
