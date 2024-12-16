import 'package:flutter/material.dart';
import 'package:medvisual/src/core/widgets/widgets.dart';

class DiseaseInformationWidget extends StatelessWidget {
  const DiseaseInformationWidget({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(child: Text(description));
  }
}
