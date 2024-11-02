import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/router/router.dart';
import 'package:medvisual/src/ui/widgets/widgets.dart';

class MainCategoryWidget extends StatelessWidget {
  const MainCategoryWidget({
    super.key,
    required this.categories,
    this.categoryName,
  });

  final Map<String, String> categories;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverMainAxisGroup(slivers: [
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 10),
        child: Text(
          categoryName ?? '',
          style: theme.textTheme.titleMedium
              ?.copyWith(fontSize: 19, fontWeight: FontWeight.w500),
        ),
      )),
      SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, childAspectRatio: 1.4),
          delegate: SliverChildBuilderDelegate(childCount: categories.length,
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
    ]);
  }
}
