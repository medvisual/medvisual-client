import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medvisual/src/repository/models/visual_disease_model.dart';
import 'package:medvisual/src/repository/requests/create_visual_request.dart';

part 'create_visual_event.dart';
part 'create_visual_state.dart';

class VisualInformationBloc
    extends Bloc<VisualInformationEvent, VisualInformationState> {
  VisualInformationBloc() : super(VisualInformationInitial()) {
    on<GetVisualDecision>((event, emit) async {
      if (state is! VisualInformationLoaded) {
        emit(VisualInformationLoading());
      }
      try {
        List<VisualDisease> visualDiseses =
            await VisualRequest.createVisualRequest(
                event.presumedDiseases, event.image);
        emit(VisualInformationLoaded(visualDiseses: visualDiseses));
      } catch (e) {
        emit(VisualInformationError(error: e.toString()));
      }
    });
  }
}
