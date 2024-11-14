import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medvisual/src/bloc/create_visual_bloc/create_visual_bloc.dart';
import 'package:medvisual/src/presentation/pages/visual/widgets/widgets.dart';
import 'package:medvisual/src/presentation/ui/widgets/widgets.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key, required this.disease});

  final String disease;

  @override
  ImagePickerPageState createState() => ImagePickerPageState();
}

class ImagePickerPageState extends State<ImagePickerPage> {
  final _visualInformationBloc = VisualInformationBloc();
  File? image;
  // Function to update the image, passed to ImagePickerWidget
  void _updateImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

// Function for getting information from ai from backend
  void _getVisualDiseases(File image) {
    _visualInformationBloc.add(
        GetVisualDecision(presumedDiseases: [widget.disease], image: image));
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
                image: image),
            const OptinalDiseasesContainer(),
            const AttentionVisualWidget(),
            VisualBottomSheet(visualInformationBloc: _visualInformationBloc),
          ],
        ),
      ),
    );
  }
}

class OptinalDiseasesContainer extends StatelessWidget {
  const OptinalDiseasesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        child: Column(
      children: [
        const Text('Добавить дополнительные болезни для сравнения'),
        const SizedBox(height: 20),
        BaseButton(
          onPressed: () {},
          text: 'Добавить',
        )
      ],
    ));
  }
}
