import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    this.radius,
  });
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 30),
        color: theme.colorScheme.surfaceContainer,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.search,
            color: theme.hintColor.withOpacity(0.7),
          ),
          const SizedBox(width: 10),
          Text('Поиск',
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: theme.hintColor.withOpacity(0.7))),
        ],
      ),
    );
  }
}
