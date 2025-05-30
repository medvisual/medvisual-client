import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/home/widgets/navigation_bar.dart';
import 'package:medvisual/src/router/router.dart';
import 'package:medvisual/src/bloc/auth_manager_bloc/auth_manager_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medvisual/src/presentation/auth/view/view.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthManagerBloc, AuthManagerState>(
      bloc: GetIt.I<AuthManagerBloc>(),
      listener: (context, state) {
        if (state is Expired) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.93,
                child: LoginPage(
                  onResult: () {
                    Navigator.pop(context);
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
      },
      child: AutoTabsRouter(
        routes: const [
          CategoriesRoute(),
          AIChatsRoute(),
          ProfileRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            extendBody: true,
            body: Column(
              children: [
                Expanded(child: child),
              ],
            ),
            bottomNavigationBar: CustomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
            ),
          );
        },
      ),
    );
  }
}
