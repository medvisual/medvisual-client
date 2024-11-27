import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medvisual/src/bloc/create_visual_bloc/create_visual_bloc.dart';
import 'package:medvisual/src/presentation/pages/diseases/view/diseases_screen.dart';
import 'package:medvisual/src/presentation/pages/visual/widgets/widgets.dart';
import 'package:medvisual/src/presentation/core/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key, required this.disease});

  final String disease;

  @override
  ImagePickerPageState createState() => ImagePickerPageState();
}

class ImagePickerPageState extends State<ImagePickerPage> {
  final _visualInformationBloc = VisualInformationBloc();

  File? image;
  Set<String> _selectedAdvancedDiseases = {};

  @override
  void initState() {
    super.initState();
    _selectedAdvancedDiseases = {widget.disease};
  }

  // Function to update the image, passed to ImagePickerWidget
  void _updateImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  // Function for getting information from AI from backend
  void _getVisualDiseases(File image) {
    _visualInformationBloc.add(
      GetVisualDecision(
        presumedDiseases: _selectedAdvancedDiseases.toList(),
        image: image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            UploadImageContainer(
              visualInformationBloc: _visualInformationBloc,
              updateImage: _updateImage,
              getVisualDiseases: _getVisualDiseases,
              image: image,
            ),
            OptinalDiseasesContainer(
              onSelected: (selected) {
                setState(() {
                  _selectedAdvancedDiseases = selected;
                });
              },
              selectedDiseases: _selectedAdvancedDiseases,
            ),
            const AttentionVisualWidget(),
            VisualBottomSheet(visualInformationBloc: _visualInformationBloc),
          ],
        ),
      ),
    );
  }
}

class OptinalDiseasesContainer extends StatefulWidget {
  final Function(Set<String>) onSelected;
  final Set<String> selectedDiseases;

  const OptinalDiseasesContainer({
    super.key,
    required this.onSelected,
    required this.selectedDiseases,
  });

  @override
  State<OptinalDiseasesContainer> createState() =>
      _OptinalDiseasesContainerState();
}

class _OptinalDiseasesContainerState extends State<OptinalDiseasesContainer> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      child: Column(
        children: [
          const Text('Добавить дополнительные болезни для сравнения'),
          const SizedBox(height: 20),
          BaseButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  isError = false;
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.92,
                            child: DiseasesScreen(
                              category: 'Пульмонология',
                              showCheckboxes: true,
                              initialSelectedDiseases: widget.selectedDiseases,
                              onResult: (diseasesSet) {
                                if (diseasesSet.isNotEmpty) {
                                  setState(() {
                                    isError = false;
                                  });
                                  widget.onSelected(diseasesSet);
                                } else {
                                  setState(() {
                                    isError = true;
                                  });
                                }
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              color: Theme.of(context).colorScheme.surface,
                              child: Center(
                                child: BaseButton(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  onPressed: () {
                                    context.router.popForced();
                                  },
                                  color: isError
                                      ? theme.primaryColor.withAlpha(100)
                                      : null,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: isError
                                      ? Text(
                                          'Выберите хотя бы одну болезнь',
                                          style: TextStyle(
                                            color: Colors.white.withAlpha(100),
                                          ),
                                        )
                                      : const Text(
                                          'Готово',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            text: 'Добавить',
          ),
        ],
      ),
    );
  }
}
