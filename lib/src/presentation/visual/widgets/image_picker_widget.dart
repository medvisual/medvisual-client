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
          SizedBox(
            height: 280,
            width: 280,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: image != null
                  ? Image.file(image!, fit: BoxFit.cover)
                  : Image.asset('assets/images/no_image_placeholder.jpg'),
            ),
          )
        ]));
  }
}
