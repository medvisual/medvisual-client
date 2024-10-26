part of 'diseases_bloc.dart';

abstract class DiseasesEvent {}

class GetDiseasesList extends DiseasesEvent {}

class AddDisease extends DiseasesEvent {
  AddDisease(
      {required this.name,
      required this.description,
      required this.department});

  final String name;
  final String description;
  final String department;
}
