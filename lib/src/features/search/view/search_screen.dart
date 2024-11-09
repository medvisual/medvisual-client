import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/features/categories/categories.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Align(
          alignment: Alignment.center,
          child: Hero(
              tag: 'search-widget',
              child: SearchWidget(
                radius: 20,
              ))),
    );
  }
}
