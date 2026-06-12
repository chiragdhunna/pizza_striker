import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_config.dart';
import 'screens/auth_gate.dart';
import 'services/api_client.dart';
import 'state/auth_provider.dart';
import 'state/settings_provider.dart';
import 'theme/app_theme.dart';

class PizzaStrikerApp extends StatelessWidget {
  const PizzaStrikerApp({
    super.key,
    required this.api,
    required this.auth,
    required this.settings,
  });

  final ApiClient api;
  final AuthProvider auth;
  final SettingsProvider settings;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: api),
        ChangeNotifierProvider<AuthProvider>.value(value: auth),
        ChangeNotifierProvider<SettingsProvider>.value(value: settings),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: settings.mode,
            home: const AuthGate(),
          );
        },
      ),
    );
  }
}
