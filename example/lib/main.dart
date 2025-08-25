import 'package:flutter/material.dart';
import 'package:safe_route/safe_route.dart';

void main() {
  runApp(MyApp());
}

final firstRoute = SafeRoute<Null, Null>(
  name: '/',
  builder: (_, _) => FirstPage(),
);

final userRoute = SafeRoute<Null, Null>(
  name: '/user',
  builder: (_, _) => MyHomePage(),
);

final settingsRoute = SafeRoute<bool, bool>(
  name: '/settings',
  builder: (_, _) => SettingsPage(),
);

final nestedRoute = SafeNestedRoute(
  name: '/nested',
  routes: [userRoute, settingsRoute],
);

class MyApp extends StatelessWidget {
  MyApp({super.key})
    : router = SafeRouter()..registerAll([nestedRoute, userRoute, firstRoute]);

  final SafeRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: userRoute.fullPath,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  VoidCallback _toSettings(BuildContext context) => () {
    Navigator.of(context).pushRoute(settingsRoute, true);
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('First')),
      floatingActionButton: FloatingActionButton(
        onPressed: _toSettings(context),
        child: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
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
