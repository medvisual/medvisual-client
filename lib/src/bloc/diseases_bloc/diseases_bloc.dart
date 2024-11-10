import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/repository/models/diseases_list/disease.dart';
import 'package:medvisual/src/repository/realm/realm_repository/disease_repository.dart';
import 'package:medvisual/src/repository/requests/disease_request.dart';
import 'package:realm/realm.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'diseases_event.dart';
part 'diseases_state.dart';

class DiseasesBloc extends Bloc<DiseasesEvent, DiseasesState> {
  DiseasesBloc() : super(DiseasesListInitial()) {
    final diseaseRepository = DiseaseRepository(realm: GetIt.I<Realm>());
    final talker = GetIt.I<Talker>();

    on<GetDiseasesList>((event, emit) async {
      try {
        emit(DiseasesListLoading());
        try {
          talker.log('Trying get diseases from realm');
          final realmDiseases = await diseaseRepository.getDiseases();
          final diseases = realmDiseases.map((realmDisease) {
            return Disease.fromRealm(realmDisease);
          }).toList();
          if (diseases.isNotEmpty) {
            emit(DiseasesListLoaded(diseasesList: diseases));
          }
        } catch (e) {
          talker.error('Realm get diseases error: $e');
          emit(DiseasesListError(error: e.toString()));
        }
        talker.log('Getting diseases from endpoint');
        final diseaseRequest = DiseaseRequest(dio: GetIt.I<Dio>());
        final allDiseasesList = await diseaseRequest.getDiseaseList();
        emit(DiseasesListLoaded(diseasesList: allDiseasesList));
        talker.log('Saving diseases from endpoint to realm');
        await diseaseRepository.setDiseases(allDiseasesList.map((e) {
          return e.toRealm();
        }).toList());
        talker.log('Diseases saved to realm!');
      } catch (e) {
        talker.error(e);
        if (state is DiseasesListLoading) {
          emit(DiseasesListError(error: e.toString()));
        }
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

    on<SearchDisease>((event, emit) async {
      try {
        emit(SearchInProgress());
        final realmDiseaseList =
            await diseaseRepository.findDiseases(event.query);
        final diseaseList = realmDiseaseList.map((e) {
          return Disease.fromRealm(e);
        }).toList();
        emit(SearchCompleted(diseasesList: diseaseList));
      } catch (e) {
        talker.error(e);
        emit(SearchError(error: e.toString()));
        throw Exception('Error was occured: $e');
      }
    });
  }
}
