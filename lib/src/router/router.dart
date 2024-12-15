import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/categories/view/categories_screen.dart';
import 'package:medvisual/src/presentation/history/view/history_screen.dart';
import 'package:medvisual/src/presentation/diseases/pages/add_disease/view/add_diseases_page.dart';
import 'package:medvisual/src/presentation/diseases/view/diseases_screen.dart';
import 'package:medvisual/src/presentation/home/view/home_screen.dart';
import 'package:medvisual/src/presentation/auth/view/login_page.dart';
import 'package:medvisual/src/presentation/profile/view/profile_screen.dart';
import 'package:medvisual/src/presentation/search/view/search_screen.dart';
import 'package:medvisual/src/presentation/settings/view/settings_screen.dart';
import 'package:medvisual/src/router/auth_route_guard.dart';
import 'package:medvisual/src/presentation/auth/view/registration_page.dart';

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
            AutoRoute(page: HistoryRoute.page, path: 'chats'),
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
            final fadeOut = Tween<double>(begin: 0, end: 1).animate(animation);
            return FadeTransition(opacity: fadeOut, child: child);
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
        AutoRoute(page: RegistrationRoute.page, path: '/registration'),
      ];
}
