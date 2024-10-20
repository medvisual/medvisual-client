part of 'create_visual_bloc.dart';

abstract class VisualInformationState {}

class VisualInformationInitial extends VisualInformationState {}

class VisualInformationLoading extends VisualInformationState {}

class VisualInformationLoaded extends VisualInformationState {
  VisualInformationLoaded({required this.visualDiseses});

  final List<VisualDisease> visualDiseses;
}

class VisualInformationError extends VisualInformationState {
  VisualInformationError({required this.error});

  final String error;
}
