import 'package:flutter/material.dart';
import 'package:medvisual/src/presentation/pages/main/main_page.dart';
import 'package:medvisual/theme/theme.dart';

class MainApp extends StatelessWidget{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MainPage()
    );
  }
}