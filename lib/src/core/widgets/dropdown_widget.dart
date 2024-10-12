// lib/widgets/adaptive_picker.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DropDownListWidget extends StatefulWidget {
  const DropDownListWidget({super.key, required this.items});
  final List<String> items;
  @override
  _DropDownListWidgetState createState() => _DropDownListWidgetState();
}

class _DropDownListWidgetState extends State<DropDownListWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Проверяем платформу: если iOS, показываем CupertinoPicker, иначе DropdownButton
    return DropdownButton<String>(
      value: widget.items[selectedIndex],
      onChanged: (String? newValue) {
        setState(() {
          selectedIndex = widget.items.indexOf(newValue!);
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
