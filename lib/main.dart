import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/app.dart';
import 'package:medvisual/src/repository/requests/create_visual_request.dart';
import 'package:medvisual/src/repository/requests/disease_request.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = TalkerFlutter.init();
  final dio = Dio();
  Bloc.observer = TalkerBlocObserver(talker: talker);
  dio.interceptors.add(TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(
      printResponseData: false,
    ),
  ));
  GetIt.I.registerLazySingleton(
      () => {VisualRequest(dio: dio), DiseaseRequest(dio: dio)});
  GetIt.I.registerSingleton(talker);
  GetIt.I.registerLazySingleton(() => dio);
  runApp(const MainApp());
}
