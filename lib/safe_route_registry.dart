import 'package:collection/collection.dart';
import 'package:safe_route/route_node.dart';
import 'package:safe_route/safe_nested_route.dart';
import 'package:safe_route/safe_route.dart';

class SafeRouteRegistry {
  final _routes = <String, RouteNode>{};

  void register(RouteNode route) {
    _routes[route.name] = route;
  }

  void registerAll(List<RouteNode> routes) {
    for (var route in routes) {
      register(route);
    }
  }

  SafeRoute? find(String name) {
    List<String> namedRoutes = name
        .split('/')
        .where((val) => val != '')
        .toList();
    return nestedFind(_routes, namedRoutes, 0);
  }

  SafeRoute? nestedFind(
    Map<String, RouteNode> routes,
    List<String> namedRoutes,
    int index,
  ) {
    if (namedRoutes.isEmpty) return routes['/'] as SafeRoute;
    if (index >= namedRoutes.length) return null;
    final current = routes.entries
        .firstWhereOrNull((r) => r.key == '/${namedRoutes[index]}')
        ?.value;
    if (current == null) return null;
    if (current case SafeRoute route) return route;
    if (current case SafeNestedRoute route) {
      return nestedFind(route.routes, namedRoutes, index + 1);
    }

    return null;
  }
}
