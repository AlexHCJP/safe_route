import 'package:flutter/material.dart';

typedef UntypedSafeRoute = SafeRoute<Object?, Object?>;

class RouteRegistry {
  final _routes = <String, UntypedSafeRoute>{};

  SafeRoute<TArgs, TResult> register<TArgs, TResult>(
    SafeRoute<TArgs, TResult> route,
  ) {
    _routes[route.name] = route;
    return route;
  }

  UntypedSafeRoute? find(String name) => _routes[name];
}

class SafeRoute<TArgs, TResult> {
  final String name;
  final Widget Function(BuildContext, TArgs) builder;

  const SafeRoute({required this.name, required this.builder});

  Route<TResult> materialPageRoute(TArgs args) {
    return MaterialPageRoute<TResult>(
      builder: (context) => builder(context, args),
      settings: RouteSettings(name: name),
    );
  }
}

class SafeRouter {
  final RouteRegistry _registry;

  SafeRouter() : _registry = RouteRegistry();

  void registerAll(List<UntypedSafeRoute> routes) {
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
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, TArgs args) {
    return push<TResult>(route.materialPageRoute(args));
  }

  Future<T?> popAndPushRoute<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    // TODO: implement popAndPushNamed
    throw UnimplementedError();
  }

  Future<T?> pushRouteAndRemoveUntil<T extends Object?>(
    Route<T> newRoute,
    RoutePredicate predicate,
  ) {
    // TODO: implement pushAndRemoveUntil
    throw UnimplementedError();
  }

  Future<T?> pushReplacementRoute<T extends Object?, TO extends Object?>(
    Route<T> newRoute, {
    TO? result,
  }) {
    // TODO: implement pushReplacement
    throw UnimplementedError();
  }

  String restorablePopAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    // TODO: implement restorablePopAndPushNamed
    throw UnimplementedError();
  }

  String restorablePushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    // TODO: implement restorablePushNamed
    throw UnimplementedError();
  }

  String restorablePushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    // TODO: implement restorablePushNamedAndRemoveUntil
    throw UnimplementedError();
  }

  String restorablePushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    // TODO: implement restorablePushReplacementNamed
    throw UnimplementedError();
  }
}
