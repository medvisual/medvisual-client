import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/ui/widgets/widgets.dart';

class DiseaseInformationWidget extends StatelessWidget {
  const DiseaseInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BaseContainer(
      child: Text(
          'Пневмони́я, воспаление лёгких — воспаление лёгочной ткани обычно инфекционного происхождения с преимущественным поражением альвеол. Пневмонии, вызванные инфекциями, являются формой острой респираторной инфекции, затрагивающей лёгкие.'),
    );
  }
}
