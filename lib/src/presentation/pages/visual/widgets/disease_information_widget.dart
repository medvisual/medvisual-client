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
      'Пневмония, воспаление лёгких, возникает в результате инфекции, чаще всего бактериальной, вирусной или грибковой природы. Симптомы включают кашель с мокротой, лихорадку, одышку и боль в груди. Диагностика проводится с помощью рентгенографии грудной клетки и лабораторных исследований. Лечение зависит от причины и может включать антибиотики, противовирусные препараты и поддерживающую терапию. Важно своевременное обращение за медицинской помощью для предотвращения осложнений.',
    ));
  }
}
