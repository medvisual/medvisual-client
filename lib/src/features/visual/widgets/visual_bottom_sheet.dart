import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medvisual/src/bloc/create_visual_bloc/create_visual_bloc.dart';

class VisualBottomSheet extends StatelessWidget {
  const VisualBottomSheet({
    super.key,
    required VisualInformationBloc visualInformationBloc,
  }) : _visualInformationBloc = visualInformationBloc;

  final VisualInformationBloc _visualInformationBloc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<VisualInformationBloc, VisualInformationState>(
      bloc: _visualInformationBloc,
      listener: (context, state) {
        if (state is VisualInformationLoaded) {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                  ),
                  child: ListView.builder(
                    itemCount: state.visualDiseses.length,
                    itemBuilder: (context, index) {
                      final disease = state.visualDiseses[index];
                      return Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: theme.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                                child: Text(
                              disease.name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.onSurface),
                            )),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Вероятность',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurface),
                                ),
                                Flexible(
                                    child:
                                        Text('${disease.probability * 100}%'))
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Вердикт',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurface),
                                ),
                                Flexible(child: Text(disease.verdict))
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Обратите внимание!',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurface),
                                ),
                                Flexible(child: Text(disease.advice))
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              });
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
