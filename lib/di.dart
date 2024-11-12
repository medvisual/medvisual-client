import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/bloc/auth_manager_bloc/auth_manager_bloc.dart';
import 'package:medvisual/src/data/repository/managers/tokenDioInterceptors/request_header_manager.dart';
import 'package:medvisual/src/data/repository/managers/token_manager/token_manager.dart';
import 'package:medvisual/src/data/repository/realm/realm_models/disease_realm.dart';
import 'package:realm/realm.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  await dotenv.load(fileName: ".env"); // loading file of enviroment

  // Create and init local db (Realm)
  final config = Configuration.local([RealmDisease.schema]);
  final realm = Realm(config);

  // Firts init secure storage for trying init users
  const secureStorage = FlutterSecureStorage();
  // Create instances
  final talker = TalkerFlutter.init();
  final dio = Dio();
  // Secure storage
  getIt.registerSingleton(secureStorage);

  // Request and dio init
  getIt.registerLazySingleton(() => dio);
  // Logger
  getIt.registerSingleton(talker);

  final authManager = AuthManagerBloc();

  // Trying get user if it was logged.
  //authManager.add(TryInitUser());

  // Connect bloc and dio with Talker (logger)
  Bloc.observer = TalkerBlocObserver(talker: talker);
  dio.interceptors.addAll([
    UpdateTokenInterceptor(tokenManager: TokenManager()),
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    )
  ]);
  // Auth states manager
  getIt.registerSingleton(authManager);
  getIt.registerSingleton(realm);
}
