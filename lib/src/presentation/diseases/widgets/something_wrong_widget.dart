import 'package:flutter/material.dart';
import 'package:medvisual/src/core/widgets/base_button.dart';

class SomethingWrongWidget extends StatelessWidget {
  const SomethingWrongWidget({
    super.key,
    required this.tryAgainCallback,
  });

  final VoidCallback tryAgainCallback;

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
          const SizedBox(height: 20),
          BaseButton(
            onPressed: tryAgainCallback,
            width: MediaQuery.of(context).size.width * 0.6,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Попробовать снова',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
