# 📦 Building a test APK with Fastlane

This project ships Fastlane lanes (in `android/fastlane/`) that build the APK
and **bake your backend URL** into it via `--dart-define=API_BASE_URL=…`.

## Prerequisites (one-time)

1. **Android toolchain** — building an APK needs the Android SDK + a JDK.
   Run `flutter doctor` and make sure **"Android toolchain"** has a ✓ (install
   Android Studio if not), then accept licenses:
   ```bash
   flutter doctor --android-licenses
   ```
2. **Ruby** — Fastlane is a Ruby tool. On Windows, install via
   [RubyInstaller](https://rubyinstaller.org/) (any 3.x). Verify with `ruby -v`.
3. **Fastlane**:
   ```bash
   cd android
   gem install bundler
   bundle install        # uses android/Gemfile
   ```
   (Or install globally: `gem install fastlane`.)

## Build the APK

From the project root:

```bash
cd android
fastlane build_apk api_base:https://pizza-striker-api.onrender.com
```

Equivalent using an env var:
```bash
API_BASE_URL=https://pizza-striker-api.onrender.com fastlane build_apk
```

Lanes available:
| Lane | Output |
|---|---|
| `fastlane build_apk` | Release APK → `build/app/outputs/flutter-apk/app-release.apk` |
| `fastlane build_apk_debug` | Debug APK → `build/app/outputs/flutter-apk/app-debug.apk` |
| `fastlane build_aab` | Release App Bundle → `build/app/outputs/bundle/release/app-release.aab` |

## Install on a device

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```
…or just copy the `.apk` to an Android phone and open it (enable "install from
unknown sources").

## Notes

- **Signing:** `flutter build apk --release` signs with the **debug key** unless
  you configure a release keystore — that's fine for **testing/sideloading**.
  For Play Store distribution, add a keystore + `signingConfig` in
  `android/app/build.gradle.kts` and a `key.properties` file.
- **Package name:** `android/fastlane/Appfile` is set to
  `com.example.pizza_striker` (the `flutter create` default). If you change the
  `applicationId`, update the Appfile to match.
- **No Fastlane?** You can always build directly without it:
  ```bash
  flutter build apk --release --dart-define=API_BASE_URL=https://pizza-striker-api.onrender.com
  ```
