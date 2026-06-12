import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App preferences: theme mode + (local-only) notification toggles.
///
/// The backend doesn't persist notification preferences, so these toggles are
/// stored on-device as UI state.
class SettingsProvider extends ChangeNotifier {
  SettingsProvider(this._prefs) {
    _load();
  }

  final SharedPreferences _prefs;

  static const _modeKey = 'ps_theme_mode';
  static const _notifyStrikesKey = 'ps_notify_strikes';
  static const _notifyPizzaKey = 'ps_notify_pizza';

  ThemeMode _mode = ThemeMode.system;
  bool _notifyOnThreeStrikes = true;
  bool _notifyOnPizzaOwed = true;

  ThemeMode get mode => _mode;
  bool get notifyOnThreeStrikes => _notifyOnThreeStrikes;
  bool get notifyOnPizzaOwed => _notifyOnPizzaOwed;

  bool isDark(BuildContext context) {
    if (_mode == ThemeMode.system) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
    return _mode == ThemeMode.dark;
  }

  void _load() {
    switch (_prefs.getString(_modeKey)) {
      case 'light':
        _mode = ThemeMode.light;
        break;
      case 'dark':
        _mode = ThemeMode.dark;
        break;
      default:
        _mode = ThemeMode.system;
    }
    _notifyOnThreeStrikes = _prefs.getBool(_notifyStrikesKey) ?? true;
    _notifyOnPizzaOwed = _prefs.getBool(_notifyPizzaKey) ?? true;
  }

  Future<void> setMode(ThemeMode mode) async {
    _mode = mode;
    notifyListeners();
    final value = mode == ThemeMode.light
        ? 'light'
        : mode == ThemeMode.dark
            ? 'dark'
            : 'system';
    await _prefs.setString(_modeKey, value);
  }

  Future<void> toggleDark(bool dark) => setMode(dark ? ThemeMode.dark : ThemeMode.light);

  Future<void> setNotifyOnThreeStrikes(bool value) async {
    _notifyOnThreeStrikes = value;
    notifyListeners();
    await _prefs.setBool(_notifyStrikesKey, value);
  }

  Future<void> setNotifyOnPizzaOwed(bool value) async {
    _notifyOnPizzaOwed = value;
    notifyListeners();
    await _prefs.setBool(_notifyPizzaKey, value);
  }
}
