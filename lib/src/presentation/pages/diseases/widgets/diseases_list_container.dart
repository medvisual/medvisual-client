import 'package:flutter/material.dart';
import 'package:medvisual/src/bloc/diseases_bloc/diseases_bloc.dart';
import 'package:medvisual/src/presentation/pages/visual/view/visual_screen.dart';

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
    final DiseasesBloc diseasesBloc = DiseasesBloc();
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
            InkWell(
              child: const Icon(Icons.delete_forever),
              onTap: () {
                diseasesBloc.add(DeleteDisease(diseaseId: id));
              },
            )
          ],
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
