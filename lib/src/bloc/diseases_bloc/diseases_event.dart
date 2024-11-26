part of 'diseases_bloc.dart';

abstract class DiseasesEvent {}

class GetDiseasesList extends DiseasesEvent {
  GetDiseasesList({required this.page});

  final int page;
}

class AddDisease extends DiseasesEvent {
  AddDisease(
      {required this.name,
      required this.description,
      required this.department});

  final String name;
  final String description;
  final String department;
}

class DeleteDisease extends DiseasesEvent {
  DeleteDisease({required this.diseaseId});

  final int diseaseId;
}

class SearchDisease extends DiseasesEvent {
  SearchDisease({required this.query});

  final String query;
}
