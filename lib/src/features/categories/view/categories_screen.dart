import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/features/categories/widgets/app_bar.dart';
import 'package:medvisual/src/features/diseases/view/diseases_screen.dart';
import 'package:medvisual/src/ui/widgets/base_list_container.dart';

@RoutePage()
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomAppBar(),
        SliverList(
            delegate: SliverChildBuilderDelegate(childCount: 10,
                (BuildContext context, int index) {
          return BaseListContainer(
            text: 'Отделение',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const DiseasesScreen(category: 'Отделение')));
            },
          );
        })),
      ],
    );
  }
}
