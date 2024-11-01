import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/bloc/auth_manager_bloc/auth_manager_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  await dotenv.load(fileName: ".env"); // loading file of enviroment

  // Firts init secure storage for trying init users
  const secureStorage = FlutterSecureStorage();
  // Secure storage
  getIt.registerSingleton(secureStorage);

  // Create instances
  final talker = TalkerFlutter.init();
  final dio = Dio();
  final authManager = AuthManagerBloc();

  // Trying get user if it was logged.
  authManager.add(TryInitUser());

  // Connect bloc and dio with Talker (logger)
  Bloc.observer = TalkerBlocObserver(talker: talker);
  dio.interceptors.add(TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(
      printResponseData: false,
    ),
  ));
  // Request and dio init
  getIt.registerLazySingleton(() => dio);
  // Logger
  getIt.registerSingleton(talker);
  // Auth states manager
  getIt.registerSingleton(authManager);
}
