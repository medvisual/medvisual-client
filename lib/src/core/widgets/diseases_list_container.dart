import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/visual/view/visual_screen.dart';

class DiseasesListContainer extends StatelessWidget {
  const DiseasesListContainer({
    super.key,
    required this.name,
    required this.id,
  });
  final String name;
  final int id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VisualScreen(disease: name, diseaseId: id)));
      },
    );
  }
}
