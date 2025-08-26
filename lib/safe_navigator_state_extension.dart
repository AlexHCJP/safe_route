import 'package:flutter/material.dart';
import 'package:safe_route/safe_route.dart';

/// Extension on [NavigatorState] that adds type-safe navigation methods
/// using [SafeRoute].
///
/// These methods are thin wrappers around the regular Flutter navigation API
/// (`pushNamed`, `popAndPushNamed`, etc.), but enforce correct
/// argument/result types at compile time.
extension AppRouteNavigation on NavigatorState {
  /// Pushes a new route onto the stack.
  ///
  /// Equivalent to [NavigatorState.pushNamed], but type-safe.
  ///
  /// Example:
  /// ```dart
  /// final result = await Navigator.of(context).pushRoute(userRoute, "Alex");
  /// ```
  Future<TResult?>
  pushRoute<TArgs, TResult, Route extends SafeRoute<TArgs, TResult>>(
    Route route,
    TArgs args,
  ) => pushNamed<TResult>(route.fullPath, arguments: args);

  /// Pops the current route and pushes a new one.
  ///
  /// Equivalent to [NavigatorState.popAndPushNamed], but type-safe.
  Future<TResult?> popAndPushRoute<
    TArgs,
    TResult,
    TPopResult,
    Route extends SafeRoute<TArgs, TResult>
  >(SafeRoute<TArgs, TResult> route, {TPopResult? result, TArgs? arguments}) =>
      popAndPushNamed<TResult, TPopResult>(
        route.fullPath,
        result: result,
        arguments: arguments,
      );

  /// Pushes a new route and removes routes until [predicate] returns true.
  ///
  /// Equivalent to [NavigatorState.pushNamedAndRemoveUntil], but type-safe.
  Future<TResult?> pushRouteAndRemoveUntil<
    TArgs,
    TResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, RoutePredicate predicate, {TArgs? arguments}) =>
      pushNamedAndRemoveUntil<TResult>(
        route.fullPath,
        predicate,
        arguments: arguments,
      );

  /// Replaces the current route with a new one.
  ///
  /// Equivalent to [NavigatorState.pushReplacementNamed], but type-safe.
  Future<TResult?> pushReplacementRoute<
    TArgs,
    TResult,
    TPopResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, {TPopResult? result, TArgs? arguments}) =>
      pushReplacementNamed<TResult, TPopResult>(
        route.fullPath,
        result: result,
        arguments: arguments,
      );

  /// Restorable version of [popAndPushRoute].
  String restorablePopAndPushRoute<
    TArgs,
    TResult,
    TPopResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, {TPopResult? result, TArgs? arguments}) =>
      restorablePopAndPushNamed<TResult, TPopResult>(
        route.fullPath,
        result: result,
        arguments: arguments,
      );

  /// Restorable version of [pushRoute].
  String
  restorablePushRoute<TArgs, TResult, Route extends SafeRoute<TArgs, TResult>>(
    Route route, {
    TArgs? arguments,
  }) => restorablePushNamed<TResult>(route.fullPath, arguments: arguments);

  /// Restorable version of [pushRouteAndRemoveUntil].
  String restorablePushRouteAndRemoveUntil<
    TArgs,
    TResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, RoutePredicate predicate, {TArgs? arguments}) =>
      restorablePushNamedAndRemoveUntil<TResult>(
        route.fullPath,
        predicate,
        arguments: arguments,
      );

  /// Restorable version of [pushReplacementRoute].
  String restorablePushReplacementRoute<
    TArgs,
    TResult,
    TPopResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, {TPopResult? result, TArgs? arguments}) =>
      restorablePushReplacementNamed<TResult, TPopResult>(
        route.fullPath,
        result: result,
        arguments: arguments,
      );
}
