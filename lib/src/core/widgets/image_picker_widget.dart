import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});
  @override
  _ImagePickerAppState createState() => _ImagePickerAppState();
}

class _ImagePickerAppState extends State<ImagePickerWidget> {
  File? _image; // Переменная для хранения выбранного изображения
  final ImagePicker _picker = ImagePicker(); // Создаём экземпляр ImagePicker

  // Функция для выбора изображения из галереи
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Преобразуем путь файла в File
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Получаем размеры экрана
        double screenWidth = MediaQuery.of(context).size.width;
        double imageSize = screenWidth * 0.8;

        return Column(
          children: [
            GestureDetector(
              onTap: _pickImage, // Выбор фото при нажатии на изображение
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.file(
                        _image!,
                        width: imageSize, // Адаптивная ширина
                        height: imageSize, // Адаптивная высота
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/images/no_image_placeholder.jpg', // Картинка-заглушка, если фото нет
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
