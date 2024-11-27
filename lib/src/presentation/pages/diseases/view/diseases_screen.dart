import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medvisual/src/bloc/diseases_bloc/diseases_bloc.dart';
import 'package:medvisual/src/presentation/pages/diseases/widgets/widgets.dart';
import 'package:medvisual/src/router/router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medvisual/src/data/models/disease/disease.dart';

@RoutePage()
class DiseasesScreen extends StatefulWidget {
  const DiseasesScreen(
      {super.key,
      required this.category,
      this.showCheckboxes = false,
      this.onResult,
      this.initialSelectedDiseases})
      : assert(initialSelectedDiseases == null || showCheckboxes == true);

  final String category;
  final bool showCheckboxes;
  final void Function(Set<String>)? onResult;
  final Set<String>? initialSelectedDiseases;

  @override
  State<DiseasesScreen> createState() => _DiseasesScreenState();
}

class _DiseasesScreenState extends State<DiseasesScreen> {
  final Set<Disease> _diseasesList = {};
  bool hasNextPage = true;

  // Bloc init
  final _diseasesListBloc = DiseasesBloc();
  //Scroll Controller
  final _scrollController = ScrollController();

  // Track selected diseases only if checkboxes are shown
  final ValueNotifier<Set<String>> _selectedDiseases =
      ValueNotifier<Set<String>>({});

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    // Initialize _selectedDiseases with initialSelectedDiseases if available
    if (widget.initialSelectedDiseases != null) {
      _selectedDiseases.value =
          Set<String>.from(widget.initialSelectedDiseases!);
    }

    _diseasesListBloc.add(GetDiseasesList());

    // Add listener to _selectedDiseases
    _selectedDiseases.addListener(_onSelectedDiseasesChanged);
  }

  @override
  void dispose() {
    _selectedDiseases.removeListener(_onSelectedDiseasesChanged);
    _selectedDiseases.dispose();
    _diseasesListBloc.close();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // TODO: Make 80% of the screen
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        hasNextPage) {
      // Reached the end of the list
      _diseasesListBloc.add(GetDiseasesList());
    }
  }

  // Listener method
  void _onSelectedDiseasesChanged() {
    // Perform actions when _selectedDiseases changes
    // For example, notify parent widget or update UI accordingly
    if (widget.onResult != null) {
      widget.onResult!(_selectedDiseases.value);
    }
  }

  // FIXME: Change logic for moderator
  bool _isModerator() {
    return true;
  }

  void _onDiseaseSelected(bool? selected, String diseaseName) {
    if (selected == true) {
      _selectedDiseases.value = {..._selectedDiseases.value, diseaseName};
    } else {
      final updatedSet = Set<String>.from(_selectedDiseases.value);
      updatedSet.remove(diseaseName);
      _selectedDiseases.value = updatedSet;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: _isModerator() && !widget.showCheckboxes
          ? FloatingActionButton(
              onPressed: () {
                context.router.push(AddDiseaseRoute(onResult: () {})).then((_) {
                  _diseasesListBloc.add(GetDiseasesList());
                });
              },
              backgroundColor: theme.primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.category,
        ),
        centerTitle: true,
        // Start of Selection
        actions: [
          if (!widget.showCheckboxes)
            IconButton(
              onPressed: () {
                context.router.push(const SearchRoute());
              },
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.search_rounded),
              ),
            ),
        ],
        leading: widget.showCheckboxes
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  context.router.popForced();
                })
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.router.popForced();
                },
              ),
      ),
      body: BlocBuilder<DiseasesBloc, DiseasesState>(
        bloc: _diseasesListBloc,
        builder: (context, state) {
          if (state is DiseasesListLoaded || _diseasesList.isNotEmpty) {
            if (state is DiseasesListLoaded) {
              _diseasesList.addAll(state.diseasesList);
              hasNextPage = state.hasNextPage ?? true;
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: _diseasesList.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == _diseasesList.length - 1 && hasNextPage) {
                  return Center(
                    child: LoadingAnimationWidget.discreteCircle(
                        color: theme.colorScheme.onSurface,
                        secondRingColor: theme.primaryColor,
                        thirdRingColor: theme.primaryColor,
                        size: 20),
                  );
                }
                final disease = _diseasesList.elementAt(index);
                if (widget.showCheckboxes) {
                  return ValueListenableBuilder<Set<String>>(
                    valueListenable: _selectedDiseases,
                    builder: (context, selectedDiseases, child) {
                      return CheckboxListTile(
                        title: Text(disease.name),
                        value: selectedDiseases.contains(disease.name),
                        activeColor: theme.primaryColor,
                        checkColor: Colors.white,
                        onChanged: (bool? selected) {
                          _onDiseaseSelected(selected, disease.name);
                        },
                      );
                    },
                  );
                } else {
                  return DiseasesListContainer(
                    key: ValueKey(disease.id),
                    name: disease.name,
                    id: disease.id!,
                  );
                }
              },
            );
          } else if (state is DiseasesListLoading && _diseasesList.isEmpty) {
            return const DiseasesLoadingWidget();
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
