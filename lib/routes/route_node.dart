import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

/// Base class for all nodes in the safe routing tree.
///
/// A [RouteNode] represents a single element in the route hierarchy.
/// It can be either:
/// - a [SafeRoute] (a leaf node with a page builder)
/// - a [SafeNestedRoute] (a container grouping other routes)
///
/// Each node has:
/// - [name] → the relative path (e.g. `"/settings"`)
/// - [_parent] → reference to its parent node
///
/// Together, they allow constructing a full path by walking up the tree.
///
/// Example:
/// ```dart
/// final profileRoute = SafeRoute<String, void>(
///   name: '/profile',
///   builder: (_, username) => ProfilePage(username: username),
/// );
///
/// final accountRoutes = SafeNestedRoute(
///   name: '/account',
///   routes: [profileRoute],
/// );
///
/// // profileRoute.fullPath == "/account/profile"
/// ```
abstract class RouteNode {
  /// Creates a new route node with a given [name].
  RouteNode({required this.name});

  /// Route path fragment (relative to its parent).
  ///
  /// For example: `"/settings"` or `"/profile"`.
  final String name;

  /// Reference to the parent route (if part of a [SafeNestedRoute]).
  RouteNode? _parent;

  /// Attaches this node to a [parent].
  ///
  /// Called internally by [SafeNestedRoute] when registering child routes.
  @protected
  set parent(RouteNode? parent) {
    if (_parent != null) throw Exception();
    _parent = parent;
  }

  /// Get parent route
  RouteNode? get parent => _parent;

  /// The full path of this route, including all parent paths.
  ///
  /// Example:
  /// ```
  /// "/account" (SafeNestedRoute)
  ///   + "/profile" (SafeRoute)
  /// = "/account/profile"
  /// ```
  String get fullPath => p.joinAll([_parent?.fullPath ?? '/', name]);
}
