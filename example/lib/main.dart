import 'package:flutter/material.dart';
import 'package:example/navigation/app_router.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key}) : _router = AppRouter();

  final AppRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: _router.safeRouter.defaultPath,
      onGenerateRoute: _router.safeRouter.onGenerateRoute,
    );
  }
}
