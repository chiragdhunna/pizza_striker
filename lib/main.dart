import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza_striker/db_helper.dart';
import 'package:pizza_striker/screens/admin_screen.dart';
import 'package:pizza_striker/screens/login_screen.dart';
import 'package:pizza_striker/services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DBHelper().initDb();

  // Initial system UI mode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  final isDarkMode = await ThemeService.loadThemeFromPrefs();

  runApp(MyApp(isDarkMode: isDarkMode));

  // 💥 Force the system UI AFTER first frame — guaranteed to work
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // change to light if dark bg
    ));
  });
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
