import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/features/categories/categories.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Align(
          alignment: Alignment.topCenter,
          child: Hero(
              tag: 'search-widget',
              child: Material(
                type: MaterialType.transparency,
                child: SearchWidget(
                  radius: 10,
                  height: 50,
                  inset: 0,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        autofocus: true,
                        cursorColor: theme.primaryColor,
                      )),
                ),
              ))),
    );
  }
}
