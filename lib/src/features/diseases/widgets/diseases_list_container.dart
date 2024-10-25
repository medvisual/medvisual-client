import 'package:flutter/material.dart';
import 'package:medvisual/src/features/visual/view/visual_screen.dart';

class DiseasesListContainer extends StatelessWidget {
  const DiseasesListContainer({
    super.key,
    required this.name,
    required this.index,
  });
  final String name;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: const Border(
                top: BorderSide(
                  color: Colors.black,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                ),
                left: BorderSide(
                  color: Colors.black,
                ),
                right: BorderSide(
                  color: Colors.black,
                ),
              ),
              borderRadius: BorderRadius.circular(25)),
          child: Center(child: Text(name)),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VisualScreen(disease: name)));
      },
    );
  }
}
