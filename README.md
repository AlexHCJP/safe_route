
# safe_route

[![pub.dev](https://img.shields.io/pub/v/safe_route.svg)](https://pub.dev/packages/safe_route)

`safe_route` is a simple and **type-safe navigation helper** for Flutter applications.  
No more `dynamic arguments` and runtime crashes — everything is strictly typed.

---

## Why?

Default Flutter navigation with `Navigator.pushNamed` requires `Object? arguments`.  
It’s flexible but unsafe:

```dart
Navigator.of(context).pushNamed('/user', arguments: 123); // ❌ runtime crash if page expects String
```

With `safe_route`, both **arguments** and **results** are typed at compile-time.

---

## Features

* ✅ Type-safe arguments and results
* ✅ Nested routes (`SafeNestedRoute`)
* ✅ Strongly typed navigation helpers
* ✅ Clean, declarative API
* ✅ Simple integration with `MaterialApp`

---

## Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
  safe_route: ^<latest_version>
```

---

## Quick Start

### 1. Define routes

```dart
final homeRoute = SafeRoute<Null, Null>(
  name: '/',
  builder: (_, __) => const HomePage(),
);

final settingsRoute = SafeRoute<Null, bool>(
  name: '/settings',
  builder: (_, __) => const SettingsPage(),
);
```

### 2. Register them in `SafeRouter`

```dart
final router = SafeRouter()
  ..registerAll([homeRoute, settingsRoute])
  ..defaultPath = homeRoute.fullPath;

MaterialApp(
  initialRoute: router.defaultPath,
  onGenerateRoute: router.onGenerateRoute,
);
```

### 3. Navigate safely

```dart
// Navigate without arguments
Navigator.of(context).pushRoute(homeRoute, null);

// Navigate with arguments
Navigator.of(context).pushRoute(userRoute, "Alex");

// Return a result
Navigator.of(context).pop(true);

// Receive a result
final isDark = await Navigator.of(context).pushRoute(settingsRoute, null);
```

---

## Navigation Methods

`safe_route` provides a convenient extension `AppRouteNavigation` on `NavigatorState`
with typed wrappers around standard navigation methods:

| Flutter API method                  | safe\_route method                  |
| ----------------------------------- | ----------------------------------- |
| `pushNamed`                         | `pushRoute`                         |
| `popAndPushNamed`                   | `popAndPushRoute`                   |
| `pushNamedAndRemoveUntil`           | `pushRouteAndRemoveUntil`           |
| `pushReplacementNamed`              | `pushReplacementRoute`              |
| `restorablePushNamed`               | `restorablePushRoute`               |
| `restorablePopAndPushNamed`         | `restorablePopAndPushRoute`         |
| `restorablePushNamedAndRemoveUntil` | `restorablePushRouteAndRemoveUntil` |
| `restorablePushReplacementNamed`    | `restorablePushReplacementRoute`    |

All methods ensure **arguments and results are strictly typed**.

---

## Nested Routes

You can group routes together with `SafeNestedRoute`:

```dart
final profileRoute = SafeRoute<Null, Null>(
  name: '/profile',
  builder: (_, __) => const ProfilePage(),
);

final userRoutes = SafeNestedRoute(
  name: '/user',
  routes: [profileRoute, settingsRoute],
);
```

---

## Full Example

```dart
final loginRoute = SafeRoute<Null, String>(
  name: '/',
  builder: (_, __) => const LoginPage(),
);

final homeRoute = SafeRoute<String, void>(
  name: '/home',
  builder: (_, username) => HomePage(username: username),
);

final settingsRoute = SafeRoute<Null, bool>(
  name: '/settings',
  builder: (_, __) => const SettingsPage(),
);

class MyApp extends StatelessWidget {
  MyApp({super.key})
      : router = SafeRouter()..registerAll([loginRoute, homeRoute, settingsRoute]);

  final SafeRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}
```