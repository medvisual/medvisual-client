part of 'diseases_bloc.dart';

abstract class DiseasesState {}

class DiseasesListInitial extends DiseasesState {}

class DiseasesListLoading extends DiseasesState {}

class DiseasesListLoaded extends DiseasesState {
  DiseasesListLoaded({required this.diseasesList, this.hasNextPage});

  final List<Disease> diseasesList;
  final bool? hasNextPage;
}

class DiseasesListError extends DiseasesState {
  DiseasesListError({this.error});

  final String? error;
}

class AddDiseaseError extends DiseasesState {
  AddDiseaseError({this.error});

  final String? error;
}

class AddDiseaseInProgress extends DiseasesState {}

class AddDiseaseComplete extends DiseasesState {}

class SearchInProgress extends DiseasesState {}

class SearchCompleted extends DiseasesState {
  SearchCompleted({required this.diseasesList});

  final List<Disease> diseasesList;
}

class SearchError extends DiseasesState {
  SearchError({required this.error});

  final String error;
}
