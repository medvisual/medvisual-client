import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medvisual/src/features/diseases/pages/add_disease/widgets/inut_field.dart';
import 'package:medvisual/src/ui/widgets/base_button.dart';

@RoutePage()
class AddDiseasePage extends StatelessWidget {
  const AddDiseasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая болезнь'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.router.back();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...[
                const Text('Название болезни'),
                InputField(
                  inputController: TextEditingController(),
                  text: 'Напишите название болезни',
                  maxLines: 1,
                )
              ],
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ...[
                const Text('Информация о болезни'),
                InputField(
                  inputController: TextEditingController(),
                  text: 'Заполните инфорамцию о болезни',
                  maxLines: 10,
                )
              ],
              SizedBox(height: MediaQuery.of(context).size.height * 0.22),
              BaseButton(text: 'Добавить болезнь', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
