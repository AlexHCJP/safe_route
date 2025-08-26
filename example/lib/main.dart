import 'package:flutter/material.dart';
import 'package:safe_route/safe_route.dart';

void main() {
  runApp(MyApp());
}

/// -------- ROUTES --------
final loginRoute = SafeRoute<Null, String>(
  name: '/',
  builder: (_, _) => const LoginPage(),
);

final homeRoute = SafeRoute<String, void>(
  name: '/home',
  builder: (_, username) => HomePage(username: username),
);

final settingsRoute = SafeRoute<Null, bool>(
  name: '/settings',
  builder: (_, _) => const SettingsPage(),
);

final shopRoute = SafeRoute<Null, String>(
  name: '/shop',
  builder: (_, _) => const ShopPage(),
);

class MyApp extends StatelessWidget {
  MyApp({super.key}) : router = SafeRouter()
    ..registerAll([loginRoute, homeRoute, settingsRoute, shopRoute]);

  final SafeRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}

/// -------- LOGIN PAGE --------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = TextEditingController();

  void _login(BuildContext context) {
    final username = controller.text.trim();
    if (username.isNotEmpty) {
      Navigator.of(context).pushRoute(homeRoute, username);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Enter your name"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------- HOME PAGE --------
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.username});
  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool darkMode = false;
  List<String> cart = [];

  Future<void> _openSettings(BuildContext context) async {
    final result = await Navigator.of(context).pushRoute(settingsRoute, null);
    if (result != null) {
      setState(() => darkMode = result);
    }
  }

  void _openShop(BuildContext context) {
    Navigator.of(context).pushRoute(shopRoute, null).then((item) {
      if (item != null) {
        setState(() => cart.add(item));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.black87 : Colors.white,
      appBar: AppBar(
        title: Text("Welcome, ${widget.username}!"),
        backgroundColor: darkMode ? Colors.grey[800] : null,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            darkMode ? "🌙 Dark mode ON" : "☀️ Light mode ON",
            style: TextStyle(
              fontSize: 18,
              color: darkMode ? Colors.white : Colors.black,
            ),
          ),
          const Divider(),
          const Text("🛒 Cart:", style: TextStyle(fontSize: 18)),
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(
                  cart[i],
                  style: TextStyle(
                      color: darkMode ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Wrap(
        spacing: 10,
        children: [
          FloatingActionButton(
            heroTag: "settings",
            onPressed: () => _openSettings(context),
            child: const Icon(Icons.settings),
          ),
          FloatingActionButton(
            heroTag: "shop",
            onPressed: () => _openShop(context),
            child: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }
}

/// -------- SETTINGS PAGE --------
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;

  void _apply(BuildContext context) {
    Navigator.of(context).pop(darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: SwitchListTile(
          title: const Text("Enable dark mode"),
          value: darkMode,
          onChanged: (v) => setState(() => darkMode = v),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _apply(context),
        child: const Icon(Icons.check),
      ),
    );
  }
}

/// -------- SHOP PAGE --------
class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  void _selectItem(BuildContext context, String item) {
    Navigator.of(context).pop(item);
  }

  @override
  Widget build(BuildContext context) {
    final items = ["🍎 Apple", "🍌 Banana", "🍫 Chocolate", "🥤 Cola"];
    return Scaffold(
      appBar: AppBar(title: const Text("Shop")),
      body: ListView(
        children: items
            .map((e) => ListTile(
                  title: Text(e),
                  onTap: () => _selectItem(context, e),
                ))
            .toList(),
      ),
    );
  }
}
