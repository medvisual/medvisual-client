import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/data/models/disease/disease.dart';
import 'package:medvisual/src/data/models/diseases_page/diseases_page.dart';
import 'package:medvisual/src/data/repository/realm/realm_models/disease_realm.dart';
import 'package:medvisual/src/data/repository/realm/realm_repository/disease_repository.dart';
import 'package:medvisual/src/data/repository/requests/disease_request.dart';
import 'package:realm/realm.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'diseases_event.dart';
part 'diseases_state.dart';

class DiseasesBloc extends Bloc<DiseasesEvent, DiseasesState> {
  final talker = GetIt.I<Talker>();
  final diseaseRepository = DiseaseRepository(realm: GetIt.I<Realm>());
  int pageNumber = 1;

  DiseasesBloc() : super(DiseasesListInitial()) {
    List<Disease> dbModelToDisease(List<RealmDisease> dbModelList) {
      final diseases = dbModelList.map((realmDisease) {
        return Disease.fromRealm(realmDisease);
      }).toList();
      return diseases;
    }

    Future<List<Disease>> getDiseasesLocal() async {
      talker.log('Trying get diseases from realm');
      final realmDiseases = await diseaseRepository.getDiseases();
      final diseases = dbModelToDisease(realmDiseases);
      return diseases;
    }

    Future<DiseasesPage> getDiseasesApi(int page) async {
      talker.log('Trying to get diseases from endpoint');
      final diseaseRequest = DiseaseRequest(dio: GetIt.I<Dio>());
      final diseasesPage = await diseaseRequest.getDiseaseList(page);

      // Update page number
      pageNumber = diseasesPage.meta.page + 1;

      return diseasesPage;
    }

    Future<void> saveDiseasesLocal(List<Disease> diseases) async {
      talker.log('Saving diseases from endpoint to realm');
      await diseaseRepository.setDiseases(diseases.map((e) {
        return e.toRealm();
      }).toList());
      talker.log('Diseases saved to realm!');
    }

    on<GetDiseasesList>((event, emit) async {
      try {
        emit(DiseasesListLoading());

        // Try to get diseases from local only if it first page (Optimization prediction for many diseases)
        if (pageNumber == 1) {
          try {
            final diseases = await getDiseasesLocal();

            if (diseases.isNotEmpty) {
              emit(DiseasesListLoaded(diseasesList: diseases));
            }
          } catch (e) {
            talker.error('Local database getting diseases error: $e');
          }
        }

        // Main logic of getting diseases from api
        final diseasesPage = await getDiseasesApi(pageNumber);
        emit(DiseasesListLoaded(
            diseasesList: diseasesPage.diseases,
            hasNextPage: diseasesPage.meta.hasNextPage));

        // Saving diseases from api to local database (Also only if it's first page)
        if (pageNumber == 1) {
          saveDiseasesLocal(diseasesPage.diseases);
        }
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
        talker.error('Error was occured: $e');
      }
    });

    on<SearchDisease>((event, emit) async {
      emit(SearchInProgress());

      try {
        final realmDiseaseList =
            await diseaseRepository.findDiseases(event.query);
        final diseaseList = dbModelToDisease(realmDiseaseList);

        emit(SearchCompleted(diseasesList: diseaseList));
      } catch (e) {
        talker.error(e);
        emit(SearchError(error: e.toString()));
      }
    });
  }
}
