import 'package:flutter/material.dart';

class DiseaseInheritWidget extends InheritedWidget {
  final String disease;
  final int diseaseId;

  const DiseaseInheritWidget({
    super.key,
    required this.disease,
    required this.diseaseId,
    required super.child,
  });

  static DiseaseInheritWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DiseaseInheritWidget>();
  }

  @override
  bool updateShouldNotify(DiseaseInheritWidget oldWidget) {
    return diseaseId != oldWidget.diseaseId;
  }
}
