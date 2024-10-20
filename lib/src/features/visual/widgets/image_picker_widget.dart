import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File) onImagePicked; // Callback to pass the selected image

  const ImagePickerWidget({super.key, required this.onImagePicked});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    Future<void> pickImage() async {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
        GetIt.I<Talker>().info('Image has been selected');
        widget.onImagePicked(
            image!); // Passing the selected image through the callback
      }
    }

    return GestureDetector(
        onTap: pickImage,
        child: Column(children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Theme.of(context).hintColor.withOpacity(0.3),
                  width: 3),
            ),
            child: image != null
                ? Image.file(image!, fit: BoxFit.cover)
                : Image.asset('assets/images/no_image_placeholder.jpg'),
          )
        ]));
  }
}
