import 'package:flutter/material.dart';
import 'package:pizza_striker/db_helper.dart';
import 'package:pizza_striker/screens/admin_screen.dart';
import 'package:pizza_striker/screens/login_screen.dart';
import 'package:pizza_striker/services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DBHelper().initDb();

  // can be null
  final bool? isDarkMode = await ThemeService.loadThemeFromPrefs();

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatelessWidget {
  final bool? isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Striker',
      theme: ThemeService.lightTheme,
      darkTheme: ThemeService.darkTheme,
      themeMode: isDarkMode == null
          ? ThemeMode.system
          : (isDarkMode! ? ThemeMode.dark : ThemeMode.light),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/admin': (context) => const AdminScreen(),
      },
    );
  }
}
