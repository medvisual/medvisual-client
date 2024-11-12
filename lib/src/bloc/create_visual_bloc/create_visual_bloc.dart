import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/data/models/visual_disease_model/visual_disease_model.dart';
import 'package:medvisual/src/data/repository/requests/create_visual_request.dart';
import 'package:medvisual/src/data/repository/managers/token_manager/token_manager.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'create_visual_event.dart';
part 'create_visual_state.dart';

class VisualInformationBloc
    extends Bloc<VisualInformationEvent, VisualInformationState> {
  VisualInformationBloc() : super(VisualInformationInitial()) {
    on<GetVisualDecision>((event, emit) async {
      emit(VisualInformationLoading());
      try {
        // Check for token valid
        final tokenManager = TokenManager();
        if (await tokenManager.isRefreshNeded()) {
          await tokenManager.refreshToken();
        }
        final visualRequest = VisualRequest(dio: GetIt.I<Dio>());
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
