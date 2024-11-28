import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/bloc/auth_manager_bloc/auth_manager_bloc.dart';
import 'package:medvisual/src/presentation/ui/widgets/inut_field.dart';
import 'package:medvisual/src/presentation/ui/widgets/base_button.dart';

@RoutePage()
class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key, required this.onResult});
  final VoidCallback onResult;

  final bloc = GetIt.I<AuthManagerBloc>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthManagerBloc, AuthManagerState>(
      listener: (context, state) {
        if (state is AuthInProgress) {
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                    child:
                        CircularProgressIndicator(color: theme.primaryColor));
              });
        } else if (state is Authenticated) {
          Navigator.pop(context);
          onResult();
        } else {
          throw Exception('Failed auth');
        }
      },
      bloc: bloc,
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
                  inputController: emailController, text: 'Почта', maxLines: 1),
              InputField(
                  obscureText: true,
                  inputController: passwordController,
                  text: 'Пароль',
                  maxLines: 1),
              InputField(
                  obscureText: true,
                  inputController: password2Controller,
                  text: 'Повторите пароль',
                  maxLines: 1),
              const SizedBox(height: 30),
              BaseButton(
                  // TODO: add registration logic
                  onPressed: () async {
                    bloc.add(Login(
                        email: emailController.text,
                        password: passwordController.text));
                  },
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(height: 20),
              Text(
                'Уже есть аккаунт? Войдите!',
                style: theme.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
