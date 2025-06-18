part of 'diseases_bloc.dart';

abstract class DiseasesState extends Equatable {}

class DiseasesListInitial extends DiseasesState {
  @override
  List<Object?> get props => [];
}

class DiseasesListLoading extends DiseasesState {
  @override
  List<Object?> get props => [];
}

class DiseasesListLoaded extends DiseasesState {
  DiseasesListLoaded({required this.diseasesList, this.hasNextPage});

  final List<Disease> diseasesList;
  final bool? hasNextPage;

  @override
  List<Object?> get props => [diseasesList, hasNextPage];
}

class DiseasesListError extends DiseasesState {
  DiseasesListError({this.error});

  final String? error;

  @override
  List<Object?> get props => [];
}

class AddDiseaseError extends DiseasesState {
  AddDiseaseError({this.error});

  final String? error;

  @override
  List<Object?> get props => [];
}

class AddDiseaseInProgress extends DiseasesState {
  @override
  List<Object?> get props => [];
}

class AddDiseaseComplete extends DiseasesState {
  @override
  List<Object?> get props => [];
}

class SearchInProgress extends DiseasesState {
  @override
  List<Object?> get props => [];
}

class SearchCompleted extends DiseasesState {
  SearchCompleted({required this.diseasesList});

  final List<Disease> diseasesList;

  @override
  List<Object?> get props => [diseasesList];
}

class SearchError extends DiseasesState {
  SearchError({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
