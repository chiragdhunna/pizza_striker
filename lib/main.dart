import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'services/api_client.dart';
import 'state/auth_provider.dart';
import 'state/settings_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final api = ApiClient();
  final auth = AuthProvider(api: api);
  final settings = SettingsProvider(prefs);

  // Restore any existing session in the background; the AuthGate shows a
  // loading state until this resolves.
  auth.bootstrap();

  runApp(PizzaStrikerApp(api: api, auth: auth, settings: settings));
}
