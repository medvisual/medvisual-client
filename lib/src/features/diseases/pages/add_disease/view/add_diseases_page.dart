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
              ...[
                const Text('Название болезни'),
                InputField(
                  inputController: nameTextController,
                  text: 'Напишите название болезни',
                  maxLines: 1,
                )
              ],
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ...[
                const Text('Информация о болезни'),
                InputField(
                  inputController: detailsTextController,
                  text: 'Заполните инфорамцию о болезни',
                  maxLines: 10,
                )
              ],
              SizedBox(height: MediaQuery.of(context).size.height * 0.22),
              BlocBuilder<DiseasesBloc, DiseasesState>(
                bloc: addDiseaseBloc,
                builder: (context, state) {
                  final theme = Theme.of(context);
                  if (state is AddDiseaseError) {
                    // TODO: Change error ui to message, not button text
                    return BaseButton(
                      content: Text(
                        'Ошибка',
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: theme.canvasColor),
                      ),
                      onPressed: () {
                        addNewDisease(addDiseaseBloc, nameTextController,
                            detailsTextController);
                      },
                      width: MediaQuery.of(context).size.width,
                    );
                  } else if (state is AddDiseaseInProgress) {
                    return BaseButton(
                        content: LoadingAnimationWidget.stretchedDots(
                          color: theme.canvasColor,
                          size: 25,
                        ),
                        onPressed: () {
                          addNewDisease(addDiseaseBloc, nameTextController,
                              detailsTextController);
                        });
                  } else {
                    debugPrint(context.router.currentPath);
                    // Success state
                    return BaseButton(
                      content: Text(
                        'Добавить болезнь',
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: theme.colorScheme.onSurface),
                      ),
                      onPressed: () {
                        addNewDisease(addDiseaseBloc, nameTextController,
                            detailsTextController);
                      },
                      width: MediaQuery.of(context).size.width,
                    );
                  }
                },
              ),
              // FIXME: Working on stack navbar // DELETE
              // SizedBox(
              //   height: 20,
              // ),
              // StackNavigationBar(
              //     selectedIndex: 0,
              //     onSelected: (_index) {
              //       setState(() {
              //         routerIndex = _index;
              //       });
              //     })
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
