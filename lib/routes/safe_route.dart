import 'package:flutter/material.dart';
import 'package:safe_route/routes/route_node.dart';

/// A strongly-typed route that holds information about a page
/// and its argument/result types.
///
/// `SafeRoute<TArgs, TResult>` ensures that:
/// - **Arguments** passed into the route are of type [TArgs].
/// - **Results** returned from the route are of type [TResult].
///
/// This prevents runtime crashes due to invalid arguments or results.
///
/// Example:
/// ```dart
/// final userRoute = SafeRoute<String, bool>(
///   name: '/user',
///   builder: (context, username) => UserPage(username: username),
/// );
///
/// // Navigate with arguments
/// final result = await Navigator.of(context).pushRoute(userRoute, "Alex");
///
/// // `result` is guaranteed to be a `bool`
/// ```
class SafeRoute<TArgs, TResult> extends RouteNode {
  /// Creates a new [SafeRoute].
  ///
  /// - [name] is the route path (e.g. `'/home'`).
  /// - [builder] is a function that builds the widget for the route,
  ///   using the provided arguments of type [TArgs].
  SafeRoute({required super.name, required this.builder});

  /// A function that builds the widget for this route.
  ///
  /// Receives:
  /// - `BuildContext`
  /// - arguments of type [TArgs]
  final Widget Function(BuildContext, TArgs) builder;

  /// Builds a [MaterialPageRoute] for this safe route.
  ///
  /// Typically used internally by [SafeRouter] when
  /// handling `onGenerateRoute`.
  ///
  /// Example:
  /// ```dart
  /// final route = userRoute.materialPageRoute("Alex");
  /// ```
  Route<TResult> materialPageRoute(TArgs args) => MaterialPageRoute<TResult>(
        builder: (context) => builder(context, args),
        settings: RouteSettings(name: fullPath, arguments: args),
      );
}
