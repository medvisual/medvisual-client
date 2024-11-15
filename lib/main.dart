import 'package:flutter/material.dart';
import 'package:medvisual/di.dart'; //dependencies file
import 'package:medvisual/src/app.dart';

void main() async {
  await setupDependencies();
  runApp(const MainApp());
}
