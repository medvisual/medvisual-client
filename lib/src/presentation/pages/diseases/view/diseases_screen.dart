import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medvisual/src/bloc/diseases_bloc/diseases_bloc.dart';
import 'package:medvisual/src/presentation/pages/diseases/widgets/widgets.dart';
import 'package:medvisual/src/router/router.dart';

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
  // Bloc init
  final _diseasesListBloc = DiseasesBloc();

  // Track selected diseases only if checkboxes are shown
  final ValueNotifier<Set<String>> _selectedDiseases =
      ValueNotifier<Set<String>>({});

  @override
  void initState() {
    super.initState();

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
    super.dispose();
  }

  // Listener method
  void _onSelectedDiseasesChanged() {
    // Perform actions when _selectedDiseases changes
    // For example, notify parent widget or update UI accordingly
    if (widget.onResult != null) {
      widget.onResult!(_selectedDiseases.value);
    }
  }

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
                context.router.push(AddDiseaseRoute(onResult: () {
                  _diseasesListBloc.add(GetDiseasesList());
                }));
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
          if (state is DiseasesListLoaded) {
            return ListView.builder(
              itemCount: state.diseasesList.length,
              itemBuilder: (BuildContext context, int index) {
                final disease = state.diseasesList[index];
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
                    name: disease.name,
                    id: disease.id!,
                  );
                }
              },
            );
          } else if (state is DiseasesListLoading) {
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
