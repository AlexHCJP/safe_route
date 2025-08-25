import 'package:flutter/material.dart';
import 'package:safe_route/route_node.dart';
import 'package:safe_route/safe_route_registry.dart';

class SafeRouter {
  final SafeRouteRegistry _registry;

  SafeRouter() : _registry = SafeRouteRegistry();

  void registerAll(List<RouteNode> routes) {
    _registry.registerAll(routes);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    final route = _registry.find(settings.name!);
    return route?.materialPageRoute(settings.arguments);
  }
}
