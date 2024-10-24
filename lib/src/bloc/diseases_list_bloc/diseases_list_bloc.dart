import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/repository/models/diseases_list/disease.dart';
import 'package:medvisual/src/repository/requests/disease_request.dart';

part 'diseases_list_event.dart';
part 'diseases_list_state.dart';

class DiseasesListBloc extends Bloc<DiseasesListEvent, DiseasesListState> {
  DiseasesListBloc() : super(DiseasesListInitial()) {
    on<GetDiseasesList>((event, emit) async {
      try {
        emit(DiseasesListLoading());
        final diseaseRequest = DiseaseRequest(dio: GetIt.I<Dio>());
        final diseasesList = await diseaseRequest.getDiseaseList();
        emit(DiseasesListLoaded(diseasesList: diseasesList));
      } catch (e) {
        emit(DiseasesListError(error: e.toString()));
      }
    });
  }
}
