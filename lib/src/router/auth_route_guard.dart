import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/bloc/auth_manager_bloc/auth_manager_bloc.dart';
import 'package:medvisual/src/presentation/pages/auth/view/view.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authManager = GetIt.I<AuthManagerBloc>();
    if (authManager.state is Authenticated) {
      resolver.next();
    } else if (authManager.state is AuthNone || authManager.state is Expired) {
      showModalBottomSheet(
        context: router.navigatorKey.currentContext!,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.93,
            child: LoginPage(
              onResult: () {
                Navigator.pop(context);
                resolver.next();
              },
              onRegistration: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.93,
                      child: RegistrationPage(
                        onResult: () {
                          Navigator.pop(context);
                          resolver.next();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      );
    }
  }
}
