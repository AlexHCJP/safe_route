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

  Future<TResult?> popAndPushRoute<
    TArgs,
    TResult,
    TPopResult,
    Route extends SafeRoute<TArgs, TResult>
  >(SafeRoute<TArgs, TResult> route, {TPopResult? result, TArgs? arguments}) {
    return popAndPushNamed<TResult, TPopResult>(
      route.fullPath,
      result: result,
      arguments: arguments,
    );
  }

  Future<TResult?> pushRouteAndRemoveUntil<
    TArgs,
    TResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, RoutePredicate predicate, {TArgs? arguments}) {
    return pushNamedAndRemoveUntil<TResult>(
      route.fullPath,
      predicate,
      arguments: arguments,
    );
  }

  Future<TResult?> pushReplacementRoute<
    TArgs,
    TResult,
    TPopResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, {TPopResult? result, TArgs? arguments}) {
    return pushReplacementNamed<TResult, TPopResult>(
      route.fullPath,
      result: result,
      arguments: arguments,
    );
  }

  String restorablePopAndPushRoute<
    TArgs,
    TResult,
    TPopResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, {TPopResult? result, TArgs? arguments}) {
    return restorablePopAndPushNamed<TResult, TPopResult>(
      route.fullPath,
      result: result,
      arguments: arguments,
    );
  }

  String restorablePushRoute<
    TArgs,
    TResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, {TArgs? arguments}) {
    return restorablePushNamed<TResult>(route.fullPath, arguments: arguments);
  }

  String restorablePushRouteAndRemoveUntil<
    TArgs,
    TResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, RoutePredicate predicate, {TArgs? arguments}) {
    return restorablePushNamedAndRemoveUntil<TResult>(
      route.fullPath,
      predicate,
      arguments: arguments,
    );
  }

  /// Restorable: pushReplacement
  String restorablePushReplacementRoute<
    TArgs,
    TResult,
    TPopResult,
    Route extends SafeRoute<TArgs, TResult>
  >(Route route, {TPopResult? result, TArgs? arguments}) {
    return restorablePushReplacementNamed<TResult, TPopResult>(
      route.fullPath,
      result: result,
      arguments: arguments,
    );
  }
}
