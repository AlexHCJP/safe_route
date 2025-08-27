import 'package:flutter/material.dart';
import 'package:safe_route/routes/route_node.dart';
import 'package:safe_route/safe_route_registry.dart';

/// A type-safe router for Flutter applications.
///
/// `SafeRouter` works together with [SafeRoute] and [SafeNestedRoute]
/// to provide strictly typed navigation with arguments and results.
///
/// Typical usage:
/// ```dart
/// final router = SafeRouter()
///   ..registerAll([homeRoute, settingsRoute]);
///
/// MaterialApp(
///   onGenerateRoute: router.onGenerateRoute,
/// );
/// ```
class SafeRouter {
  /// Creates a new [SafeRouter] with its own internal [SafeRouteRegistry].
  SafeRouter() : _registry = SafeRouteRegistry();

  /// The internal registry that stores all routes.
  final SafeRouteRegistry _registry;

  /// Registers a list of [RouteNode] (routes or nested routes).
  ///
  /// Example:
  /// ```dart
  /// router.registerAll([homeRoute, settingsRoute]);
  /// ```
  void registerAll(List<RouteNode> routes) => _registry.registerAll(routes);

  /// Set default path
  set defaultPath(String path) => _registry.defaultPath = path;

  /// Get default path
  String get defaultPath => _registry.defaultPath;

  /// A callback for [MaterialApp.onGenerateRoute].
  ///
  /// It looks up the requested route inside the registry and builds
  /// a [MaterialPageRoute] if the route exists.
  ///
  /// Example:
  /// ```dart
  /// MaterialApp(
  ///   onGenerateRoute: router.onGenerateRoute,
  /// );
  /// ```
  Route<Object?>? onGenerateRoute(RouteSettings settings) {
    final route = _registry.find(settings.name!);
    return route?.materialPageRoute(settings.arguments);
  }
}
