import 'package:safe_route/route_node.dart';

class SafeNestedRoute extends RouteNode {
  SafeNestedRoute({required super.name, required List<RouteNode> routes})
    : routes = {for (final route in routes) route.name: route} {
    for (final route in routes) {
      route.wrap(this);
    }
  }

  final Map<String, RouteNode> routes;
}
