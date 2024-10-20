import 'package:flutter/material.dart';
import 'package:medvisual/src/features/visual/pages/visual_disease_page.dart';
import 'package:medvisual/src/features/visual/pages/information_page.dart';

class VisualScreen extends StatefulWidget {
  const VisualScreen({super.key, required this.disease});
  final String disease;

  @override
  State<VisualScreen> createState() => _VisualScreenState();
}

class _VisualScreenState extends State<VisualScreen> {
  int _currentPageIndex = 0;

  void _setPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.disease),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => _setPage(0),
                  child: Text(
                    'Информация',
                    style: TextStyle(
                      color: _currentPageIndex == 0
                          ? theme.primaryColor
                          : theme.hintColor.withOpacity(0.3),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _setPage(1),
                  child: Text(
                    'ИИ',
                    style: TextStyle(
                      color: _currentPageIndex == 1
                          ? theme.primaryColor
                          : theme.hintColor
                              .withOpacity(0.3), // Подсветка активной кнопки
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(children: [
          const SizedBox(height: 20),
          _currentPageIndex == 0
              ? const InformationPage()
              : const ImagePickerPage(),
        ]));
  }
}
