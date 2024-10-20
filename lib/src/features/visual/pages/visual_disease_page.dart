import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medvisual/src/bloc/create_visual_bloc/create_visual_bloc.dart';
import 'package:medvisual/src/features/visual/widgets/image_picker_widget.dart';

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

// Function for getting informatgion from ai from backend
  void _getVisualDiseases(File image) {
    _visualInformationBloc.add(GetVisualDecision(
        presumedDiseases: ['COVID-19, Pneumonia, Tumor'], image: image));
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
          const SizedBox(height: 30),
          showErrorChooseImage
              ? Text(
                  'Сначала выберите изображение!',
                  style: TextStyle(color: theme.indicatorColor),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: image != null
                ? () {
                    _getVisualDiseases(image!);
                  }
                : () {
                    setState(() {
                      showErrorChooseImage = true;
                    });
                  },
            child: BlocBuilder<VisualInformationBloc, VisualInformationState>(
              bloc: _visualInformationBloc,
              builder: (context, state) {
                if (state is VisualInformationLoading) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                      strokeWidth: 2.5,
                    ),
                  );
                }
                return Text('Получить информацию',
                    style: TextStyle(color: theme.primaryColor));
              },
            ),
          ),
          BlocListener<VisualInformationBloc, VisualInformationState>(
            bloc: _visualInformationBloc,
            listener: (context, state) {
              if (state is VisualInformationLoaded) {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ListView.builder(
                        itemCount: state.visualDiseses.length,
                        itemBuilder: (context, index) {
                          final disease = state.visualDiseses[index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                    child: Text(
                                  disease.name,
                                  style: theme.textTheme.titleLarge,
                                )),
                                Row(
                                  children: [
                                    Text(
                                      'Вероятность',
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                    Text(disease.probability.toString())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Вердикт',
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                    Text(disease.verdict)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Обратите внимание!',
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                    Text(disease.advice)
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    });
              }
            },
            child: const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
