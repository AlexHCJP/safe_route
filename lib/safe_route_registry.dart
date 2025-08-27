import 'package:collection/collection.dart';
import 'package:safe_route/safe_route.dart';

/// A registry that stores and resolves [SafeRoute] and [SafeNestedRoute].
///
/// Used internally by [SafeRouter] to:
/// - Register all available routes
/// - Find the correct route when a name is requested in `onGenerateRoute`
class SafeRouteRegistry {
  /// Internal storage for registered routes.
  ///
  /// Keys are route names (e.g. `"/"`, `"/home"`, `"/settings"`).
  final _routes = <String, RouteNode>{};

  /// Registers a list of routes into the registry.
  ///
  /// Supports both [SafeRoute] and [SafeNestedRoute].
  ///
  /// Example:
  /// ```dart
  /// registry.registerAll([homeRoute, settingsRoute, nestedRoute]);
  /// ```
  void registerAll(List<RouteNode> routes) {
    for (final route in routes) {
      _routes[route.name] = route;
    }
  }

  /// Finds a [SafeRoute] by its full name.
  ///
  /// Splits the name into segments and recursively searches through
  /// nested routes if necessary.
  ///
  /// Example:
  /// ```dart
  /// final route = registry.find('/user/settings');
  /// ```
  SafeRoute<Object?, Object?>? find(String name) {
    final namedRoutes = name.split('/').where((val) => val != '').toList();
    return _nestedFind(_routes, namedRoutes, 0);
  }

  /// Internal recursive search for routes.
  ///
  /// - If the route is a [SafeRoute], returns it.
  /// - If the route is a [SafeNestedRoute], continues searching deeper.
  /// - Returns `null` if no match is found.
  SafeRoute<Object?, Object?>? _nestedFind(
    Map<String, RouteNode> routes,
    List<String> namedRoutes,
    int index,
  ) {
    // Special case: root route `/`
    if (namedRoutes.isEmpty) {
      if (routes['/'] case SafeRoute<Object?, Object?> route) return route;
      if (routes['/'] case SafeNestedRoute route)
        return _nestedFind(route.routes, ['/'], index + 1);
    }

    if (index >= namedRoutes.length) return null;

    // Try to match current segment
    final current = routes.entries
        .firstWhereOrNull((r) => r.key == '/${namedRoutes[index]}')
        ?.value;

    if (current == null) return null;

    // Case 1: Found a SafeRoute
    if (current case SafeRoute<Object?, Object?> route) return route;

    // Case 2: Found a SafeNestedRoute → search inside it
    if (current case SafeNestedRoute route) {
      return _nestedFind(route.routes, namedRoutes, index + 1);
    }

    return null;
  }
}
