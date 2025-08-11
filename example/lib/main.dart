import 'package:flutter/material.dart';
import 'package:safe_route/safe_route.dart';

void main() {
  runApp(const MyApp());
}

final userRoute = AppRoute<Null, Null>(
  name: '/',
  builder: (context, userId) => MyHomePage(),
);

final settingsRoute = AppRoute<bool, bool>(
  name: '/home',
  builder: (context, value) => SettingsPage(),
);

final safeRouter = SafeRoute()..registerAll([userRoute, settingsRoute]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: safeRouter.onGenerateRoute);
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  VoidCallback _toSettings(BuildContext context) => () {
    Navigator.of(context).pushRoute(settingsRoute, true);
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Home')),
      floatingActionButton: FloatingActionButton(
        onPressed: _toSettings(context),
        child: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  VoidCallback _toHome(BuildContext context) => () {
    Navigator.of(context).pushRoute(userRoute, null);
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Settings')),
      floatingActionButton: FloatingActionButton(
        onPressed: _toHome(context),
        child: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
