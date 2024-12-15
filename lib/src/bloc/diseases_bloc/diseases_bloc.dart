import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/data/remote/models/disease/disease.dart';
import 'package:medvisual/src/data/remote/models/diseases_page/diseases_page.dart';
import 'package:medvisual/src/data/local/models/disease_realm.dart';
import 'package:medvisual/src/data/local/repository/local_disease_repository_impl.dart';
import 'package:medvisual/src/data/remote/request/disease_request.dart';
import 'package:medvisual/src/domain/remote_repository/disease_repository.dart';
import 'package:realm/realm.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'diseases_event.dart';
part 'diseases_state.dart';

class DiseasesBloc extends Bloc<DiseasesEvent, DiseasesState> {
  final talker = GetIt.I<Talker>();
  final localDiseaseRepository =
      LocalDiseaseRepositoryImpl(realm: GetIt.I<Realm>());
  final DiseaseRepository diseaseRepository;

  int pageNumber = 1;
  bool hasNextPage = true;

  DiseasesBloc(this.diseaseRepository) : super(DiseasesListInitial()) {
    List<Disease> dbModelToDisease(List<RealmDisease> dbModelList) {
      final diseases = dbModelList.map((realmDisease) {
        return Disease.fromRealm(realmDisease);
      }).toList();
      return diseases;
    }

    Future<List<Disease>> getDiseasesLocal() async {
      talker.log('Trying get diseases from realm');
      final realmDiseases = await localDiseaseRepository.getDiseases();
      final diseases = dbModelToDisease(realmDiseases);
      return diseases;
    }

    Future<void> saveDiseasesLocal(List<Disease> diseases) async {
      talker.log('Saving diseases from endpoint to realm');
      await localDiseaseRepository.setDiseases(diseases.map((e) {
        return e.toRealm();
      }).toList());
      talker.log('Diseases saved to realm!');
    }

    Future<DiseasesPage> getDiseasesApi(int page, String? department) async {
      talker.log('Trying to get diseases from endpoint');
      final diseasesPage =
          await diseaseRepository.getDiseases(page, department);
      // Saving diseases from api to local database (Also only if it's first page)
      if (diseasesPage.meta.page == 1) {
        saveDiseasesLocal(diseasesPage.diseases);
      }

      // Update page number
      pageNumber = diseasesPage.meta.page + 1;
      hasNextPage = diseasesPage.meta.hasNextPage;

      return diseasesPage;
    }

    on<GetDiseasesList>((event, emit) async {
      if (!hasNextPage) return;

      await _onGetDiseasesList(emit, event, getDiseasesLocal, getDiseasesApi);
    });

    on<AddDisease>((event, emit) async {
      await _onAddDisease(emit, event);
    });

    on<DeleteDisease>((event, emit) async {
      await _onDeleteDisease(event);
    });

    on<SearchDisease>((event, emit) async {
      await _onSearchDisease(emit, event, dbModelToDisease);
    });
  }

  Future<void> _onSearchDisease(
      Emitter<DiseasesState> emit,
      SearchDisease event,
      List<Disease> Function(List<RealmDisease> dbModelList)
          dbModelToDisease) async {
    emit(SearchInProgress());

    try {
      final realmDiseaseList =
          await localDiseaseRepository.findDiseases(event.query);
      final diseaseList = dbModelToDisease(realmDiseaseList);

      emit(SearchCompleted(diseasesList: diseaseList));
    } catch (e) {
      talker.error(e);
      emit(SearchError(error: e.toString()));
    }
  }

  Future<void> _onDeleteDisease(DeleteDisease event) async {
    try {
      await diseaseRepository.deleteDisease(event.diseaseId);
      talker.log('Disease deleted from endpoint!');
      await localDiseaseRepository.deleteDisease(event.diseaseId);
      talker.log('Disease deleted from local database!');
    } catch (e) {
      talker.error('Error was occured: $e');
    }
  }

  Future<void> _onAddDisease(
      Emitter<DiseasesState> emit, AddDisease event) async {
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
  }

  Future<void> _onGetDiseasesList(
      Emitter<DiseasesState> emit,
      GetDiseasesList event,
      Future<List<Disease>> Function() getDiseasesLocal,
      Future<DiseasesPage> Function(int page, String? department)
          getDiseasesApi) async {
    try {
      emit(DiseasesListLoading());

      // Trying get diseases from local database only if it's first page (Optimization prediction for many diseases)
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
      if (hasNextPage) {
        final diseasesPage = await getDiseasesApi(pageNumber, event.department);
        emit(DiseasesListLoaded(
            diseasesList: diseasesPage.diseases, hasNextPage: hasNextPage));
      }
    } catch (e) {
      talker.error(e);
      if (state is DiseasesListLoading) {
        emit(DiseasesListError(error: e.toString()));
      }
    }
  }
}
