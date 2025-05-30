import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/categories/widgets/widgets.dart';

@RoutePage()
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> categories = {
      'Онкология': 'oncology',
      'Рентгенология': 'radiology',
      'Кардиология': 'cardiology',
      'Ортопедия': 'orthopedics',
      'Пульмонология': 'pulmonology',
      'Другие': 'other'
    };
    return CustomScrollView(slivers: [
      const CustomAppBar(),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 92),
        sliver: SliverMainAxisGroup(slivers: [
          MainCategoryWidget(
            categories: categories,
            categoryName: 'Отделения',
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          RecentlyAddedDiseases(categories: categories),
        ]),
      ),
    ]);
  }
}
