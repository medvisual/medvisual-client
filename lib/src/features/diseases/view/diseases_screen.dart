import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medvisual/src/bloc/diseases_bloc/diseases_bloc.dart';
import 'package:medvisual/src/features/diseases/widgets/widgets.dart';
import 'package:medvisual/src/router/router.dart';

@RoutePage()
class DiseasesScreen extends StatefulWidget {
  const DiseasesScreen({super.key, required this.category});
  final String category;

  @override
  State<DiseasesScreen> createState() => _DiseasesScreenState();
}

class _DiseasesScreenState extends State<DiseasesScreen> {
  // Bloc init
  final _diseasesListBloc = DiseasesBloc();

  @override
  void initState() {
    _diseasesListBloc.add(GetDiseasesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const AddDiseaseRoute());
        },
        backgroundColor: theme.primaryColor,
        child: Icon(
          Icons.add,
          color: theme.canvasColor,
        ),
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.router.back();
          },
        ),
      ),
      body: BlocBuilder<DiseasesBloc, DiseasesState>(
        bloc: _diseasesListBloc,
        builder: (context, state) {
          if (state is DiseasesListLoaded) {
            return ListView.builder(
              itemCount: state.diseasesList.length,
              itemBuilder: (BuildContext context, int index) {
                return DiseasesListContainer(
                  index: index,
                  name: state.diseasesList[index].name,
                );
              },
            );
          } else if (state is DiseasesListLoading) {
            return ListView.builder(
              // or this
              // child: LoadingAnimationWidget.stretchedDots(
              //   color: theme.primaryColor,
              //   size: 60,
              // ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return const ShimmerComtainer();
              },
            );
          } else {
            return SomethingWrongWidget(
              tryAgainCallback: () {
                _diseasesListBloc.add(GetDiseasesList());
              },
            );
          }
        },
      ),
    );
  }
}
