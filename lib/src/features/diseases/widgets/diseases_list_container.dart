import 'package:flutter/material.dart';
import 'package:medvisual/src/features/visual/view/visual_screen.dart';

class DiseasesListContainer extends StatelessWidget {
  const DiseasesListContainer({
    super.key,
    required this.name,
    required this.index,
  });
  final String name;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Text(
          name,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.onSurface),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VisualScreen(disease: name)));
      },
    );
  }
}
