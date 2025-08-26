import 'package:safe_route/route_node.dart';

/// A container for grouping multiple routes under a common path.
///
/// Works like a "namespace" for routes, so you can organize related
/// [SafeRoute] instances together.
///
/// Example:
/// ```dart
/// final userRoute = SafeRoute<String, void>(
///   name: '/profile',
///   builder: (_, username) => UserProfilePage(username: username),
/// );
///
/// final settingsRoute = SafeRoute<void, bool>(
///   name: '/settings',
///   builder: (_, __) => SettingsPage(),
/// );
///
/// final accountRoutes = SafeNestedRoute(
///   name: '/account',
///   routes: [userRoute, settingsRoute],
/// );
///
/// final router = SafeRouter()
///   ..registerAll([accountRoutes]);
///
/// // Full paths will be:
/// // "/account/profile"
/// // "/account/settings"
/// ```
class SafeNestedRoute extends RouteNode {
  /// Creates a nested route container.
  ///
  /// - [name] is the base path for this group (e.g. `"/account"`).
  /// - [routes] are child routes inside this namespace.
  SafeNestedRoute({required super.name, required List<RouteNode> routes})
    : routes = {for (final route in routes) route.name: route} {
    for (final route in routes) {
      // Attach parent reference to each child
      route.wrap(this);
    }
  }

  /// All child routes registered inside this nested route.
  ///
  /// Keys are route names (relative to this nested group).
  final Map<String, RouteNode> routes;
}
