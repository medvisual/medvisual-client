import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/presentation/visual/widgets/disease_inherit_widget.dart';
import 'package:medvisual/src/core/widgets/base_button.dart';
import 'package:medvisual/src/bloc/diseases_bloc/diseases_bloc.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    this.onResult,
  });

  final VoidCallback? onResult;

  @override
  Widget build(BuildContext context) {
    final diseaseBloc = GetIt.I<DiseasesBloc>();
    return BaseButton(
      onPressed: () {
        diseaseBloc.add(DeleteDisease(
            diseaseId: DiseaseInheritWidget.of(context)?.diseaseId ??
                (throw Exception('Disease ID is not provided'))));
        onResult?.call();
      },
      color: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      text: 'Удалить болезнь',
    );
  }
}
