import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:safe_route/safe_route.dart';

/// A registry that stores and resolves [SafeRoute] and [SafeNestedRoute].
///
/// Used internally by [SafeRouter] to:
/// - Register all available routes
/// - Find the correct route when a name is requested in `onGenerateRoute`
class SafeRouteRegistry {
  /// Creates a new [SafeRouteRegistry].
  SafeRouteRegistry();

  /// Path that will be used for the first navigation (initial route).
  ///
  /// By default it is set to `'/'`, but can be overridden
  String defaultPath = '/';

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

  /// Finds a [SafeRoute] by its full [name].
  ///
  /// Splits the path into segments and recursively searches through
  /// nested routes if necessary.
  ///
  /// If this is the **first navigation**, the [name] is ignored
  /// and the registry falls back to the [_defaultPath].
  ///
  /// Example:
  /// ```dart
  /// final route = registry.find('/user/settings');
  /// ```
  SafeRoute<Object?, Object?>? find(String name) {
    final namedRoutes = p.split(isFirst ? defaultPath : name);
    isFirst = false;
    return _nestedFind(_routes, namedRoutes, 0);
  }

  /// Whether this is the very first call to [find].
  ///
  /// Used to determine whether the [_defaultPath] should be used.
  bool isFirst = true;

  /// Internal recursive search for routes.
  ///
  /// This method traverses the nested route tree according to [namedRoutes].
  ///
  /// - If the current entry is a [SafeRoute], it is returned directly.
  /// - If it is a [SafeNestedRoute], recursion continues deeper.
  /// - If no exact match is found, tries to resolve against the previous
  ///   segment to support nested `"/"` routes.
  /// - Returns `null` if no match is found at all.
  SafeRoute<Object?, Object?>? _nestedFind(
    Map<String, RouteNode> routes,
    List<String> namedRoutes,
    int index,
  ) {
    final currentNameRoute = namedRoutes.elementAtOrNull(index);
    final prevNameRoute =
        namedRoutes.elementAtOrNull(index == 0 ? 0 : index - 1);

    // Try to match current segment directly
    final current = routes.entries
        .firstWhereOrNull(
            (r) => r.key == currentNameRoute || r.key == '/$currentNameRoute')
        ?.value;

    // If no direct match found, try resolving against the previous segment
    if (current == null) {
      if (routes[prevNameRoute] case SafeNestedRoute route) {
        return _nestedFind(route.routes, namedRoutes, index);
      }
      if (routes[prevNameRoute] case SafeRoute<Object?, Object?> route) {
        return route;
      }
    }

    // Case 1: Found a SafeRoute
    if (current case SafeRoute<Object?, Object?> route) return route;

    // Case 2: Found a SafeNestedRoute → search inside it
    if (current case SafeNestedRoute route) {
      return _nestedFind(route.routes, namedRoutes, index + 1);
    }

    return null;
  }
}
