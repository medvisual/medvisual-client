import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medvisual/src/bloc/diseases_bloc/diseases_bloc.dart';
import 'package:medvisual/src/features/categories/categories.dart';
import 'package:medvisual/src/ui/widgets/widgets.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Bloc init
  final _diseasesBloc = DiseasesBloc();

  @override
  void initState() {
    _diseasesBloc.add(GetDiseasesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Hero(
                          tag: 'search-widget',
                          child: Material(
                            type: MaterialType.transparency,
                            child: SearchWidget(
                              radius: 10,
                              height: 50,
                              inset: 0,
                              child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    autofocus: true,
                                    cursorColor: theme.primaryColor,
                                    onChanged: (value) {
                                      _diseasesBloc
                                          .add(SearchDisease(query: value));
                                    },
                                  )),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          onPressed: () {
                            context.router.popForced();
                          },
                          icon: const Icon(
                            Icons.close,
                          )),
                    )
                  ],
                )),
            Expanded(
              child: BlocBuilder<DiseasesBloc, DiseasesState>(
                bloc: _diseasesBloc,
                builder: (context, state) {
                  if (state is DiseasesListLoaded) {
                    return ListView.builder(
                      itemCount: state.diseasesList.length,
                      itemBuilder: (context, index) {
                        return BaseListContainer(
                          text: state.diseasesList[index].name,
                        );
                      },
                    );
                  } else if (state is SearchCompleted) {
                    return ListView.builder(
                      itemCount: state.diseasesList.length,
                      itemBuilder: (context, index) {
                        return BaseListContainer(
                          text: state.diseasesList[index].name,
                        );
                      },
                    );
                  } else if (state is DiseasesListLoading ||
                      state is SearchInProgress) {
                    return LoadingAnimationWidget.dotsTriangle(
                        color: Colors.white, size: 30);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
