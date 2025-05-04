import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:medvisual/src/core/widgets/widgets.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the size of the screen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text('MedGPT'),
          leading: IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {},
          ),
          surfaceTintColor: theme.colorScheme.surface,
          backgroundColor: theme.colorScheme.surface,
          centerTitle: true,
          pinned: true,
        ),
        SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return HistoryListElement();
            })
      ]),
    );
  }
}

class HistoryListElement extends StatelessWidget {
  const HistoryListElement({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(
        'Текстовые названия DioHыоesada',
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
      subtitle: Text(
        '20:20',
        style: TextStyle(color: theme.hintColor),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
    );
  }
}
