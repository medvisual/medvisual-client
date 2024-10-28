import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/router/router.dart';
import 'package:medvisual/src/ui/widgets/inut_field.dart';
import 'package:medvisual/src/ui/widgets/base_button.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.router.navigate(const HomeRoute());
              },
              icon: const Icon(Icons.close)),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Добро пожаловать!',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                InputField(
                    inputController: TextEditingController(),
                    text: 'Почта',
                    maxLines: 1),
                InputField(
                    inputController: TextEditingController(),
                    text: 'Пароль',
                    maxLines: 1),
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Забыли пароль?',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.onSecondary),
                    )),
                const SizedBox(height: 30),
                BaseButton(
                    // Example of realization
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                                child: CircularProgressIndicator(
                                    color: theme.primaryColor));
                          });
                      await Future.delayed(const Duration(seconds: 1));
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    content: const Text(
                      'Войти',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(height: 20),
                Text(
                  'Нету аккаунта? Зарегистрируйся!',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ));
  }
}
