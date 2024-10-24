import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medvisual/src/bloc/create_visual_bloc/create_visual_bloc.dart';
import 'package:medvisual/src/features/visual/widgets/image_picker_widget.dart';
import 'package:medvisual/src/features/visual/widgets/visual_bottom_sheet.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final _visualInformationBloc = VisualInformationBloc();
  File? image;
  bool showErrorChooseImage = false;

  // Function to update the image, passed to ImagePickerWidget
  void _updateImage(File newImage) {
    setState(() {
      image = newImage;
      showErrorChooseImage = false;
    });
  }

// Function for getting information from ai from backend
  void _getVisualDiseases(File image) {
    _visualInformationBloc.add(GetVisualDecision(
        presumedDiseases: ['Цироз печени, Пневмония, Рак легких'],
        image: image));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Passing callback to update the image
          ImagePickerWidget(onImagePicked: _updateImage),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: image != null
                ? () {
                    _getVisualDiseases(image!);
                  }
                : () {
                    final snackBar = SnackBar(
                      content: Wrap(
                        children: [
                          Center(
                            child: Text(
                              'Пожалуйста, выберите фото',
                              style: TextStyle(color: theme.indicatorColor),
                            ),
                          )
                        ],
                      ),
                      backgroundColor: theme.canvasColor,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
            child: BlocBuilder<VisualInformationBloc, VisualInformationState>(
              bloc: _visualInformationBloc,
              builder: (context, state) {
                if (state is VisualInformationLoading) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                    child: LoadingAnimationWidget.stretchedDots(
                      color: theme.primaryColor,
                      size: 40,
                    ),
                  );
                }
                return Text('Получить информацию',
                    style: TextStyle(color: theme.primaryColor));
              },
            ),
          ),
          VisualBottomSheet(visualInformationBloc: _visualInformationBloc),
        ],
      ),
    );
  }
}
