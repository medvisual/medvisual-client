import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/features/categories/widgets/app_bar.dart';
import 'package:medvisual/src/router/router.dart';
import 'package:medvisual/src/ui/widgets/base_list_container.dart';

@RoutePage()
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categories = {
      'Неврология': 'brain',
      'Ортопедия': 'bone',
      'Педиатрия': 'bear',
      'Офтальмология': 'eye',
      'Психиатрия': 'butterfly',
      'Другие': 'other'
    };
    return CustomScrollView(
      slivers: [
        const CustomAppBar(),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 92),
          sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate(childCount: categories.length,
                      (BuildContext context, int index) {
            final categoryName = categories.keys.toList()[index];
            final categoryIcon = categories.values.toList()[index];
            return BaseListContainer(
              text: categoryName,
              icon: 'assets/icons/$categoryIcon.svg',
              onTap: () {
                context.router.push(DiseasesRoute(category: categoryName));
              },
            );
          })),
        ),
      ],
    );
  }
}
