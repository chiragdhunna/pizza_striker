/// Central app configuration.
class AppConfig {
  AppConfig._();

  static const String appName = 'Pizza Striker';

  /// Base URL of the Pizza Striker FastAPI backend.
  ///
  /// Pick the right value for where you run the app:
  ///   - Android emulator  -> http://10.0.2.2:8080   (10.0.2.2 == host machine)
  ///   - iOS simulator     -> http://localhost:8080
  ///   - Web / desktop      -> http://localhost:8080
  ///   - Physical device    -> http://<your-computer-LAN-IP>:8080
  ///
  /// You can override at run time with:
  ///   flutter run --dart-define=API_BASE_URL=http://192.168.1.50:8080
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080',
  );

  /// Strikes needed to trigger a pizza party. Mirrors STRIKE_THRESHOLD on the
  /// backend (default 3). Used only for client-side meter rendering / warnings.
  static const int strikeThreshold = 3;
}
