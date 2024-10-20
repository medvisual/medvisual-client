import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/repository/models/visual_disease_model.dart';
import 'package:medvisual/src/repository/requests/create_visual_request.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'create_visual_event.dart';
part 'create_visual_state.dart';

class VisualInformationBloc
    extends Bloc<VisualInformationEvent, VisualInformationState> {
  VisualInformationBloc() : super(VisualInformationInitial()) {
    on<GetVisualDecision>((event, emit) async {
      emit(VisualInformationLoading());
      try {
        final visualRequest = GetIt.I<VisualRequest>();
        List<VisualDisease> visualDiseses = await visualRequest
            .createVisualRequest(event.presumedDiseases, event.image);
        emit(VisualInformationLoaded(visualDiseses: visualDiseses));
      } catch (e, st) {
        emit(VisualInformationError(error: e.toString()));
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }
}
