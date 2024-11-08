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
        AutoRoute(page: HomeRoute.page, path: '/', children: [
          AutoRoute(page: CategoriesRoute.page, path: 'categories'),
          AutoRoute(page: ChatRoute.page, path: 'chats'),
          AutoRoute(page: ProfileRoute.page, path: 'profile'),
        ]),
        CustomRoute(
            page: SearchRoute.page,
            path: '/search',
            transitionsBuilder: TransitionsBuilders.slideTop,
            durationInMilliseconds: 300,
            opaque: true),
        AutoRoute(page: SettingsRoute.page, path: '/settings'),
        AutoRoute(page: DiseasesRoute.page, path: '/diseases'),
        AutoRoute(
            page: AddDiseaseRoute.page,
            path: '/add_disease',
            guards: [AuthGuard()]),
        AutoRoute(page: LoginRoute.page, path: '/login'),
      ];
}
