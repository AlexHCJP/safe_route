import 'package:flutter/material.dart';

class RouteRegistry {
  final _routes = <String, AppRoute<dynamic, dynamic>>{};

  AppRoute<TArgs, TResult> register<TArgs, TResult>(
    AppRoute<TArgs, TResult> route,
  ) {
    _routes[route.name] = route;
    return route;
  }

  AppRoute<dynamic, dynamic>? find(String name) => _routes[name];
}

class AppRoute<TArgs, TResult> {
  final String name;
  final Widget Function(BuildContext, TArgs) builder;

  const AppRoute({required this.name, required this.builder});

  Route<TResult> materialPageRoute(TArgs args) {
    return MaterialPageRoute<TResult>(
      builder: (context) => builder(context, args),
      settings: RouteSettings(name: name),
    );
  }
}

class SafeRoute {
  final RouteRegistry _registry;

  SafeRoute() : _registry = RouteRegistry();

  void registerAll(List<AppRoute<dynamic, dynamic>> routes) {
    for (var route in routes) {
      _registry.register(route);
    }
  }

  Route? onGenerateRoute(RouteSettings settings) {
    final route = _registry.find(settings.name!);
    return route?.materialPageRoute(settings.arguments);
  }
}

extension AppRouteNavigation on NavigatorState {
  Future<TResult?> pushRoute<
    TArgs,
    TResult,
    Route extends AppRoute<TArgs, TResult>
  >(Route route, TArgs args) {
    return push<TResult>(route.materialPageRoute(args));
  }
}
