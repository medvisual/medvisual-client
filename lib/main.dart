import 'package:flutter/material.dart';
import 'package:medvisual/di.dart'; //dependencies file
import 'package:medvisual/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupDependencies();
  runApp(const MainApp());
}
