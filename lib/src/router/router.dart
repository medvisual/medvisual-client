import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/pages/categories/view/categories_screen.dart';
import 'package:medvisual/src/presentation/pages/chats/view/chat_screen.dart';
import 'package:medvisual/src/presentation/pages/diseases/pages/add_disease/view/add_diseases_page.dart';
import 'package:medvisual/src/presentation/pages/diseases/view/diseases_screen.dart';
import 'package:medvisual/src/presentation/pages/home/view/home_screen.dart';
import 'package:medvisual/src/presentation/pages/auth/view/login_page.dart';
import 'package:medvisual/src/presentation/pages/profile/view/profile_screen.dart';
import 'package:medvisual/src/presentation/pages/search/view/search_screen.dart';
import 'package:medvisual/src/presentation/pages/settings/view/settings_screen.dart';
import 'package:medvisual/src/router/auth_route_guard.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(page: CategoriesRoute.page, path: 'categories'),
            AutoRoute(page: ChatRoute.page, path: 'chats'),
            AutoRoute(page: ProfileRoute.page, path: 'profile'),
          ],
          // transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //   // For HomeRoute, we can control the secondary animation (previous screen)
          //   final fadeOut =
          //       Tween<double>(begin: 1, end: 0).animate(secondaryAnimation);
          //   return FadeTransition(opacity: fadeOut, child: child);
          // },
          // opaque: true,
        ),

        // Custom Route for Search with Slide transition from top
        CustomRoute(
          page: SearchRoute.page,
          path: '/search',
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fadeOut = Tween<Offset>(
                    begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(animation);
            return SlideTransition(position: fadeOut, child: child);
          },
          durationInMilliseconds: 200,
          opaque: true,
        ),

        AutoRoute(page: SettingsRoute.page, path: '/settings'),
        AutoRoute(
          page: DiseasesRoute.page,
          path: '/diseases',
        ),
        AutoRoute(
          page: AddDiseaseRoute.page,
          path: '/add_disease',
          guards: [AuthGuard()],
        ),
        AutoRoute(page: LoginRoute.page, path: '/login'),
      ];
}
