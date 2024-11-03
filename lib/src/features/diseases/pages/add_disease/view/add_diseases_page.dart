import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medvisual/src/bloc/diseases_bloc/diseases_bloc.dart';
import 'package:medvisual/src/ui/widgets/inut_field.dart';
import 'package:medvisual/src/ui/widgets/base_button.dart';

@RoutePage()
class AddDiseasePage extends StatefulWidget {
  const AddDiseasePage({super.key});

  @override
  State<AddDiseasePage> createState() => _AddDiseasePageState();
}

class _AddDiseasePageState extends State<AddDiseasePage> {
  final nameTextController = TextEditingController();
  final detailsTextController = TextEditingController();
  final addDiseaseBloc = DiseasesBloc();
  int routerIndex = 0;

  @override
  void dispose() {
    nameTextController.dispose();
    detailsTextController.dispose();
    addDiseaseBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Название болезни'),
              InputField(
                inputController: nameTextController,
                text: 'Напишите название болезни',
                maxLines: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const Text('Информация о болезни'),
              InputField(
                inputController: detailsTextController,
                text: 'Заполните информацию о болезни',
                maxLines: 10,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.22),
              BlocListener<DiseasesBloc, DiseasesState>(
                bloc: addDiseaseBloc,
                listener: (context, state) {
                  if (state is AddDiseaseError) {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Ошибка'),
                        content: const Text('Не удалось добавить болезнь.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('ОК',
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface)),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: BaseButton(
                  onPressed: () {
                    addNewDisease(addDiseaseBloc, nameTextController,
                        detailsTextController);
                  },
                  width: MediaQuery.of(context).size.width * 0.9,
                  content: BlocBuilder<DiseasesBloc, DiseasesState>(
                    bloc: addDiseaseBloc,
                    builder: (context, state) {
                      if (state is AddDiseaseInProgress) {
                        return LoadingAnimationWidget.stretchedDots(
                          color: theme.colorScheme.onSurface,
                          size: 40,
                        );
                      } else {
                        return Text(
                          'Добавить болезнь',
                          style: TextStyle(color: theme.colorScheme.onSurface),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addNewDisease(
      DiseasesBloc addDiseaseBloc,
      TextEditingController nameTextController,
      TextEditingController detailsTextController) {
    addDiseaseBloc.add(AddDisease(
        name: nameTextController.text,
        description: detailsTextController.text,
        department: 'Неврология'));
  }
}
