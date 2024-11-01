import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medvisual/src/features/settings/widgets/widgets.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.router.back();
            },
          ),
          title: const Text('Настройки'),
        ),
        body: Column(
          children: [
            const SettingCategoryWidget(
              categoryTitle: 'Персонализация',
              onCategoryWidgets: [
                OnCategoryWidget(
                  leftWidget: Text('Изменить цвет темы'),
                  rightWidget: Text('Синий'),
                ),
                OnCategoryWidget(
                  leftWidget: Text('Сменить тему'),
                  rightWidget: Text('Тёмная'),
                )
              ],
            ),
            SettingCategoryWidget(
              categoryTitle: 'Конфиденциальность',
              onCategoryWidgets: [
                OnCategoryWidget(
                    leftWidget: const Text('Сообщения Telegram'),
                    rightWidget:
                        Switch.adaptive(value: true, onChanged: (value) {})),
                OnCategoryWidget(
                    leftWidget: const Text('Видимость профиля'),
                    rightWidget:
                        Switch.adaptive(value: false, onChanged: (value) {})),
              ],
            ),
            SettingCategoryWidget(
                categoryTitle: 'Дополнительно',
                onCategoryWidgets: [
                  OnCategoryWidget(
                      leftWidget: const Text('Подключить Telegram'),
                      rightWidget:
                          SvgPicture.asset('assets/icons/telegram.svg'))
                ])
          ],
        ));
  }
}
