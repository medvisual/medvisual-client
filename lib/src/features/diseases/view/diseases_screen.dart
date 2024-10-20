import 'package:flutter/material.dart';
import 'package:medvisual/src/features/visual/view/visual_screen.dart';

class DiseasesScreen extends StatelessWidget {
  const DiseasesScreen({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.search_rounded),
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(10),
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
                child: const Center(child: Text('Болезнь')),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const VisualScreen(disease: 'Пневмония')));
            },
          );
        },
      ),
    );
  }
}
