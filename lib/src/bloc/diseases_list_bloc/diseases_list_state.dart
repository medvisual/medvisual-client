part of 'diseases_list_bloc.dart';

abstract class DiseasesListState {}

class DiseasesListInitial extends DiseasesListState {}

class DiseasesListLoading extends DiseasesListState {}

class DiseasesListLoaded extends DiseasesListState {
  DiseasesListLoaded({required this.diseasesList});

  final List<Disease> diseasesList;
}

class DiseasesListError extends DiseasesListState {
  DiseasesListError({this.error});

  final String? error;
}
