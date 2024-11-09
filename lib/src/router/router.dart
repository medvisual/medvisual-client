import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/features/categories/view/categories_screen.dart';
import 'package:medvisual/src/features/chats/view/chat_screen.dart';
import 'package:medvisual/src/features/diseases/pages/add_disease/view/add_diseases_page.dart';
import 'package:medvisual/src/features/diseases/view/diseases_screen.dart';
import 'package:medvisual/src/features/home/view/home_screen.dart';
import 'package:medvisual/src/features/auth/view/login_page.dart';
import 'package:medvisual/src/features/profile/view/profile_screen.dart';
import 'package:medvisual/src/features/search/view/search_screen.dart';
import 'package:medvisual/src/features/settings/view/settings_screen.dart';
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
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // For HomeRoute, we can control the secondary animation (previous screen)
              final fadeOut = Tween<double>(begin: 1.0, end: 0.0)
                  .animate(secondaryAnimation);
              return FadeTransition(opacity: fadeOut, child: child);
            }),

        // Custom Route for Search with Slide transition from top
        CustomRoute(
          page: SearchRoute.page,
          path: '/search',
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final slideIn = Tween<Offset>(
              begin: const Offset(0, -1), // Coming from the top
              end: Offset.zero, // Ends at the original position
            ).animate(animation);

            return SlideTransition(position: slideIn, child: child);
          },
          durationInMilliseconds: 300,
          opaque: true,
        ),

        AutoRoute(page: SettingsRoute.page, path: '/settings'),
        AutoRoute(page: DiseasesRoute.page, path: '/diseases'),
        AutoRoute(
          page: AddDiseaseRoute.page,
          path: '/add_disease',
          guards: [AuthGuard()],
        ),
        AutoRoute(page: LoginRoute.page, path: '/login'),
      ];
}
