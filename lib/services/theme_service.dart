import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _themeKey = 'isDarkMode';

  // Get current theme mode from shared preferences
  static Future<bool> loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }

  // Save theme mode to shared preferences
  static Future<void> saveThemeToPrefs(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, isDarkMode);
  }

  // Check if current theme is dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Toggle theme mode and update shared preferences
  static void toggleTheme(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    // Get InheritedWidget managing theme
    final appState = context.findAncestorStateOfType<_ThemeManagerState>();
    appState?.setThemeMode(!isDarkMode);

    // Save preference
    saveThemeToPrefs(!isDarkMode);
  }

  // Define theme data
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[50],
    primaryColor: const Color(0xFFE84D15),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFFE84D15),
      secondary: const Color(0xFFE84D15),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF121823),
    primaryColor: const Color(0xFFE84D15),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFFE84D15),
      secondary: const Color(0xFFE84D15),
      surface: const Color(0xFF1E2A38),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E2A38),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey[400]),
    ),
  );
}

// ThemeManager InheritedWidget to manage theme state
class ThemeManager extends StatefulWidget {
  final Widget child;

  const ThemeManager({Key? key, required this.child}) : super(key: key);

  @override
  State<ThemeManager> createState() => _ThemeManagerState();
}

class _ThemeManagerState extends State<ThemeManager> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    bool savedMode = await ThemeService.loadThemeFromPrefs();
    setState(() {
      _isDarkMode = savedMode;
    });
  }

  void setThemeMode(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ThemeManagerInherited(
      isDarkMode: _isDarkMode,
      child: widget.child,
    );
  }
}

class _ThemeManagerInherited extends InheritedWidget {
  final bool isDarkMode;

  const _ThemeManagerInherited({
    Key? key,
    required this.isDarkMode,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_ThemeManagerInherited oldWidget) {
    return isDarkMode != oldWidget.isDarkMode;
  }
}
