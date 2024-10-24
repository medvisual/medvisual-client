import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/features/home/widgets/navigation_bar.dart';
import 'package:medvisual/src/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        CategoriesRoute(),
        ChatRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: SafeArea(child: child),
          bottomNavigationBar: CustomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
          ),
        );
      },
    );
  }
}
