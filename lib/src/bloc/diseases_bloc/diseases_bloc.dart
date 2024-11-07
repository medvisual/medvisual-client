import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/repository/models/diseases_list/disease.dart';
import 'package:medvisual/src/repository/requests/disease_request.dart';

part 'diseases_event.dart';
part 'diseases_state.dart';

class DiseasesBloc extends Bloc<DiseasesEvent, DiseasesState> {
  DiseasesBloc() : super(DiseasesListInitial()) {
    on<GetDiseasesList>((event, emit) async {
      try {
        emit(DiseasesListLoading());
        final diseaseRequest = DiseaseRequest(dio: GetIt.I<Dio>());
        final allDiseasesList = await diseaseRequest.getDiseaseList();
        final categoryDiseasesList = allDiseasesList;
        // TODO: Change for departemnt sort
        // final categoryDiseases = allDiseasesList.map((disease) {
        //   if (disease.department == '') {
        //     return disease;
        //   }
        // }) as List<Disease>;
        emit(DiseasesListLoaded(diseasesList: categoryDiseasesList));
      } catch (e) {
        emit(DiseasesListError(error: e.toString()));
      }
    });

    on<AddDisease>((event, emit) async {
      try {
        final diseaseRequest = DiseaseRequest(dio: GetIt.I<Dio>());
        emit(AddDiseaseInProgress());
        Disease disease = Disease(
            name: event.name,
            description: event.description,
            department: event.department);
        await diseaseRequest.addDisease(disease);

        emit(AddDiseaseComplete());
      } catch (e) {
        emit(AddDiseaseError(error: e.toString()));
      }
    });

    on<DeleteDisease>((event, emit) async {
      try {
        final diseaseRequest = DiseaseRequest(dio: GetIt.I<Dio>());
        await diseaseRequest.deleteDisease(event.diseaseId);
      } catch (e) {
        throw Exception('Error was occured: $e');
      }
    });
  }
}
