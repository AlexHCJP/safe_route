import 'package:flutter/material.dart';
import 'package:safe_route/safe_route.dart';

extension AppRouteNavigation on NavigatorState {

  
  Future<TResult?> pushRoute<
    TArgs,
    TResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, TArgs args) {
    return pushNamed<TResult>(route.fullPath, arguments: args);
  }

  Future<T?> popAndPushRoute<T extends Object?, TO extends Object?, A>(
    SafeRoute<A, T> route, {
    TO? result,
    A? arguments,
  }) {
    return popAndPushNamed<T, TO>(
      route.fullPath,
      result: result,
      arguments: arguments,
    );
  }

  Future<T?> pushRouteAndRemoveUntil<T extends Object?, A>(
    SafeRoute<A, T> route,
    RoutePredicate predicate, {
    A? arguments,
  }) {
    return pushNamedAndRemoveUntil<T>(
      route.fullPath,
      predicate,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacementRoute<T extends Object?, TO extends Object?, A>(
    SafeRoute<A, T> route, {
    TO? result,
    A? arguments,
  }) {
    return pushReplacementNamed<T, TO>(
      route.fullPath,
      result: result,
      arguments: arguments,
    );
  }

  String restorablePopAndPushRoute<T extends Object?, TO extends Object?, A>(
    SafeRoute<A, T> route, {
    TO? result,
    A? arguments,
  }) {
    return restorablePopAndPushNamed<T, TO>(
      route.fullPath,
      result: result,
      arguments: arguments,
    );
  }

  String restorablePushRoute<T extends Object?, A>(
    SafeRoute<A, T> route, {
    A? arguments,
  }) {
    return restorablePushNamed<T>(route.fullPath, arguments: arguments);
  }

  String restorablePushRouteAndRemoveUntil<T extends Object?, A>(
    SafeRoute<A, T> route,
    RoutePredicate predicate, {
    A? arguments,
  }) {
    return restorablePushNamedAndRemoveUntil<T>(
      route.fullPath,
      predicate,
      arguments: arguments,
    );
  }

  /// Restorable: pushReplacement
  String restorablePushReplacementRoute<
    T extends Object?,
    TO extends Object?,
    A
  >(SafeRoute<A, T> route, {TO? result, A? arguments}) {
    return restorablePushReplacementNamed<T, TO>(
      route.fullPath,
      result: result,
      arguments: arguments,
    );
  }
}
