import 'package:flutter/material.dart';
import 'package:safe_route/route_node.dart';

export 'route_node.dart';
export 'safe_navigator_state_extension.dart';
export 'safe_nested_route.dart';
export 'safe_route_registry.dart';
export 'safe_router.dart';

class SafeRoute<TArgs, TResult> extends RouteNode {
  SafeRoute({required super.name, required this.builder});

  final Widget Function(BuildContext, TArgs) builder;

  Route<TResult> materialPageRoute(TArgs args) {
    return MaterialPageRoute<TResult>(
      builder: (context) => builder(context, args),
      settings: RouteSettings(name: fullPath, arguments: args),
    );
  }
}
