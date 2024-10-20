part of 'create_visual_bloc.dart';

abstract class VisualInformationEvent {}

class GetVisualDecision extends VisualInformationEvent {
  GetVisualDecision({required this.presumedDiseases, required this.image});

  final List<String> presumedDiseases;
  final File image;
}
