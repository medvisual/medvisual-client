import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medvisual/src/bloc/create_visual_bloc/create_visual_bloc.dart';
import 'package:medvisual/src/features/visual/widgets/widgets.dart';
import 'package:medvisual/src/ui/widgets/widgets.dart';

class UploadImageContainer extends StatelessWidget {
  const UploadImageContainer(
      {super.key,
      required this.visualInformationBloc,
      required this.updateImage,
      required this.getVisualDiseases,
      required this.image});

  final VisualInformationBloc visualInformationBloc;
  final dynamic Function(File) updateImage;
  final dynamic Function(File) getVisualDiseases;
  final File? image;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ImagePickerWidget(onImagePicked: updateImage),
          const SizedBox(height: 60),
          BaseButton(
            width: MediaQuery.of(context).size.width * 0.62,
            onPressed: image != null
                ? () {
                    getVisualDiseases(image!);
                  }
                : () {
                    //TODO: Some logic for none selected image
                  },
            content: BlocBuilder<VisualInformationBloc, VisualInformationState>(
              bloc: visualInformationBloc,
              builder: (context, state) {
                if (state is VisualInformationLoading) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                    child: LoadingAnimationWidget.stretchedDots(
                      color: theme.colorScheme.onSurface,
                      size: 40,
                    ),
                  );
                }
                return const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Получить информацию',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
