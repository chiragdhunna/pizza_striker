import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza_striker/db_helper.dart';
import 'package:pizza_striker/screens/admin_screen.dart';
import 'package:pizza_striker/screens/login_screen.dart';
import 'package:pizza_striker/services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  await DBHelper().initDb();

  // Load the saved theme preference
  bool isDarkMode = await ThemeService.loadThemeFromPrefs();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void _setThemeMode(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
    ThemeService.saveThemeToPrefs(isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeManager(
      child: MaterialApp(
        title: 'Pizza Striker',
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/admin': (context) => const AdminScreen(),
        },
        theme: ThemeService.lightTheme,
        darkTheme: ThemeService.darkTheme,
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
