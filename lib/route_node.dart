
abstract class RouteNode {
  final String name;
  RouteNode? _parent;

  void wrap(RouteNode parent) {
    _parent = parent;
  }

  String get fullPath => (_parent?.fullPath ?? '') + name;

  RouteNode({required this.name});
}