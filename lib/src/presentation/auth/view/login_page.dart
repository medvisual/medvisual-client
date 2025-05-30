import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/bloc/auth_manager_bloc/auth_manager_bloc.dart';
import 'package:medvisual/src/core/widgets/inut_field.dart';
import 'package:medvisual/src/core/widgets/base_button.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage(
      {super.key, required this.onResult, required this.onRegistration});
  final VoidCallback onResult;
  final VoidCallback onRegistration;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = GetIt.I<AuthManagerBloc>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthManagerBloc, AuthManagerState>(
      listener: (context, state) {
        if (state is AuthInProgress) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Авторизация в процессе'),
              duration: Duration(milliseconds: 200),
            ),
          );
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: CircularProgressIndicator(color: theme.primaryColor),
                );
              });
        } else if (state is Authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: theme.highlightColor,
              content: const Text(
                'Вы успешно вошли!',
                style: TextStyle(color: Colors.white),
              )));
          Navigator.pop(context);
          widget.onResult();
        } else if (state is AuthNone) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Ошибка при входе! Проверьте введенные данные',
                  style: TextStyle(color: Colors.white),
                )));
          }
        } else {
          Navigator.pop(context);
        }
      },
      bloc: bloc,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close)),
                  ),
                ),
                Text(
                  'Добро пожаловать!',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                InputField(
                    inputController: emailController,
                    text: 'Почта',
                    maxLines: 1),
                InputField(
                    obscureText: true,
                    inputController: passwordController,
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
                      // Добавления события в Bloc для входа
                      bloc.add(Login(
                          email: emailController.text,
                          password: passwordController.text));
                    },
                    child: const Text(
                      'Войти',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(height: 20),
                TextButton(
                    child: Text(
                      'Нету аккаунта? Зарегистрируйся!',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: widget.onRegistration)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
