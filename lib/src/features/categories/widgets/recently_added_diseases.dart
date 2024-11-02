import 'dart:math';
import 'package:flutter/material.dart';
import 'package:medvisual/src/ui/widgets/widgets.dart';

class RecentlyAddedDiseases extends StatelessWidget {
  const RecentlyAddedDiseases({
    super.key,
    required this.categories,
  });

  final Map<String, String> categories;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: [
      const SliverPadding(
          padding: EdgeInsets.only(left: 15, bottom: 10),
          sliver: SliverToBoxAdapter(
              child: Text(
            'Недавно добавленные',
            style: TextStyle(fontSize: 19),
          ))),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return BaseListContainer(
                icon:
                    'assets/icons/${categories.values.toList()[Random().nextInt(categories.length)]}.svg',
                text: 'Болезнь $index',
                width: 200,
              );
            },
          ),
        ),
      ),
    ]);
  }
}
