import 'package:safe_route/safe_route.dart';
import 'package:example/features/home/view/screens/home_screen.dart';
import 'package:example/features/note/view/screens/note_create_screen.dart';
import 'package:example/features/note/view/screens/note_screen.dart';
import 'package:example/features/note/view/screens/note_update_screen.dart';
import 'package:example/features/todo/view/screens/todo_create_screen.dart';
import 'package:example/features/todo/view/screens/todo_screen.dart';
import 'package:example/features/todo/view/screens/todo_update_screen.dart';

class AppRouter {
  AppRouter() : safeRouter = SafeRouter() {
    safeRouter
      ..registerAll([mainRoute])
      ..defaultPath = homeRoute.fullPath;
  }

  final SafeRouter safeRouter;

  late final mainRoute = SafeNestedRoute(
    name: '/',
    routes: [homeRoute, todoNestedRoute, noteNestedRoute],
  );

  final homeRoute = SafeRoute<Null, Null>(
    name: '/home',
    builder: (context, _) => HomeScreen(),
  );

  final noteRoute = SafeRoute<Null, Null>(
    name: '/',
    builder: (context, _) => NoteScreen(),
  );

  final noteCreateRoute = SafeRoute<Null, Null>(
    name: '/create',
    builder: (context, _) => NoteCreateScreen(),
  );

  final noteUpdateRoute = SafeRoute<Null, Null>(
    name: '/create',
    builder: (context, _) => NoteUpdateScreen(),
  );

  late final noteNestedRoute = SafeNestedRoute(
    name: '/note',
    routes: [noteRoute, noteCreateRoute, noteUpdateRoute],
  );

  final todoRoute = SafeRoute<Null, Null>(
    name: '/',
    builder: (context, _) => TodoScreen(),
  );

  final todoCreateRoute = SafeRoute<Null, Null>(
    name: '/create',
    builder: (context, _) => TodoCreateScreen(),
  );

  final todoUpdateRoute = SafeRoute<Null, Null>(
    name: '/update',
    builder: (context, _) => TodoUpdateScreen(),
  );

  late final todoNestedRoute = SafeNestedRoute(
    name: '/todo',
    routes: [todoRoute, todoCreateRoute, todoUpdateRoute],
  );
}
