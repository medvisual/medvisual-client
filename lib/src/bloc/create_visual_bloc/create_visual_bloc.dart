import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/data/remote/models/visual_disease_model/visual_disease_model.dart';
import 'package:medvisual/src/domain/managers/token_manager/token_manager.dart';
import 'package:medvisual/src/domain/remote_repository/visual_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'create_visual_event.dart';
part 'create_visual_state.dart';

class VisualInformationBloc
    extends Bloc<VisualInformationEvent, VisualInformationState> {
  final VisualRepository visualRepository;
  VisualInformationBloc(this.visualRepository)
      : super(VisualInformationInitial()) {
    on<GetVisualDecision>((event, emit) async {
      emit(VisualInformationLoading());
      try {
        // Check for token valid
        final tokenManager = GetIt.I<TokenManager>();
        if (await tokenManager.isRefreshNeded()) {
          await tokenManager.refreshToken();
        }
        final visualDiseases = await visualRepository.makeVerdict(
            event.image, event.presumedDiseases);
        emit(VisualInformationLoaded(visualDiseses: visualDiseases));
      } catch (e, st) {
        emit(VisualInformationError(error: e.toString()));
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }
}
