import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:medvisual/src/bloc/auth_manager_bloc/auth_manager_bloc.dart';
import 'package:medvisual/src/data/repository/managers/tokenDioInterceptors/request_header_manager.dart';
import 'package:medvisual/src/data/repository/managers/token_manager/token_manager.dart';
import 'package:medvisual/src/data/repository/realm/realm_models/disease_realm.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize local database (Realm)
  final config = Configuration.local([RealmDisease.schema]);
  final realm = Realm(config);

  // FIXME: DELETE THIS LOGIC
  realm.write(() {
    realm.deleteAll<RealmDisease>();
  });

  // Initialize secure storage
  const secureStorage = FlutterSecureStorage();
  getIt.registerSingleton(secureStorage);

  // Initialize logger
  final talker = TalkerFlutter.init();
  getIt.registerSingleton(talker);

  // Initialize Dio for HTTP requests
  final dio = Dio();
  getIt.registerLazySingleton(() => dio);

  // Initialize AuthManagerBloc
  final authManager = AuthManagerBloc();
  getIt.registerSingleton(authManager);

  // Attempt to initialize user if previously logged in
  authManager.add(TryInitUser());

  // Set up Bloc observer with logger
  Bloc.observer = TalkerBlocObserver(talker: talker);

  // Add interceptors to Dio
  dio.interceptors.addAll([
    UpdateTokenInterceptor(tokenManager: TokenManager()), // Token management
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false, // Do not print response data
      ),
    ),
  ]);

  // Register Realm instance
  getIt.registerSingleton(realm);
}
