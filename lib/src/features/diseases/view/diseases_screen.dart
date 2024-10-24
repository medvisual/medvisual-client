import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medvisual/src/bloc/diseases_list_bloc/diseases_list_bloc.dart';
import 'package:medvisual/src/features/visual/view/visual_screen.dart';

class DiseasesScreen extends StatefulWidget {
  const DiseasesScreen({super.key, required this.category});
  final String category;

  @override
  State<DiseasesScreen> createState() => _DiseasesScreenState();
}

class _DiseasesScreenState extends State<DiseasesScreen> {
  // Bloc init
  final _diseasesListBloc = DiseasesListBloc();

  @override
  void initState() {
    _diseasesListBloc.add(GetDiseasesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          widget.category,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.search_rounded),
              ))
        ],
      ),
      body: BlocBuilder<DiseasesListBloc, DiseasesListState>(
        bloc: _diseasesListBloc,
        builder: (context, state) {
          if (state is DiseasesListLoaded) {
            return ListView.builder(
              itemCount: state.diseasesList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Center(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.08,
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: const Border(
                            top: BorderSide(
                              color: Colors.black,
                            ),
                            bottom: BorderSide(
                              color: Colors.black,
                            ),
                            left: BorderSide(
                              color: Colors.black,
                            ),
                            right: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      child:
                          Center(child: Text(state.diseasesList[index].name)),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const VisualScreen(disease: 'Пневмония')));
                  },
                );
              },
            );
          } else if (state is DiseasesListLoading) {
            final theme = Theme.of(context);
            return Center(
              child: LoadingAnimationWidget.stretchedDots(
                color: theme.primaryColor,
                size: 40,
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }
        },
      ),
    );
  }
}
