import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                border: Border.all(color: Colors.black)),
            child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRmqU95si1mey18wvFS8nvQDMfezindgOA3Q&s'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
              'Пневмони́я, воспаление лёгких — воспаление лёгочной ткани обычно инфекционного происхождения с преимущественным поражением альвеол. Пневмонии, вызванные инфекциями, являются формой острой респираторной инфекции, затрагивающей лёгкие.'),
        ),
      ],
    );
  }
}
