import 'package:flutter/material.dart';
import 'package:medvisual/src/core/widgets/dropdown_widget.dart';
import 'package:medvisual/src/core/widgets/image_picker_widget.dart';

class MainPage extends StatelessWidget{
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['Pneumonia', 'COVID-19', 'Tumor', 'Cancer']; // Got from backend

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medvisual'),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              const ImagePickerWidget(),
              const SizedBox(height: 30),
              DropDownListWidget(items: items),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: (){},
                child: Text('GO'),
              )
            ],
          ),
        )
      ),
    );
  }
}