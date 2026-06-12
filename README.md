# 🍕 Pizza Striker — Flutter App

The mobile/web client for the **Pizza Striker** backend. Employees track their
strikes; admins hand them out — and when someone hits 3 strikes, it's **Pizza
Time!** 🎉

This app is a clean, **code-generation-free** Flutter project (plain Dart
models + Dio + Provider). It implements the full mockup set in **light & dark**
themes and talks to the real FastAPI backend.

---

## ✅ Prerequisites

- Flutter SDK **3.16+** (Dart 3.3+). Check with `flutter --version`.
- The **Pizza Striker backend** running and reachable (see the backend repo).

## 🚀 Getting started

This zip contains the source (`lib/`, `pubspec.yaml`, `assets/`) but **not** the
platform folders (`android/`, `ios/`, `web/`, …). Regenerate them — this does
**not** touch your `lib/` code:

```bash
cd pizza_striker
flutter create .          # regenerates android/ios/web/... using the existing pubspec
flutter pub get
flutter run
```

## 🔌 Pointing the app at your backend

The base URL lives in `lib/config/app_config.dart`. The default is
`http://10.0.2.2:8080`, which is **the host machine as seen from an Android
emulator**. Choose the right value for your setup:

| Where you run the app | Base URL |
|---|---|
| Android emulator | `http://10.0.2.2:8080` (default) |
| iOS simulator / web / desktop | `http://localhost:8080` |
| Physical device | `http://<your-computer-LAN-IP>:8080` |

You can override it at run time without editing code:

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.50:8080
```

> Make sure the backend is up (`docker compose up`) and that CORS allows your
> origin if you run the app on web.

## 🔑 Default login

The backend seeds a default admin on first start:

- **Username:** `admin`  **Password:** `admin123`

Log in as admin to manage employees and strikes, or **Register** a new account
(registration creates an *employee*).

## 📱 Screens

- **Login / Register** — JWT auth with a role toggle.
- **Employee dashboard** — your strike meter, strike history, and pizza you owe.
- **Notifications** — strikes, revocations, and pizza events; mark read.
- **Admin dashboard** — searchable employee list with one-tap **Add Strike**, plus who currently owes pizza.
- **Add Strike** — reason + a warning when it's the party-triggering 3rd strike.
- **Pizza party overlay** — celebratory dialog when the threshold is hit.
- **Team Status** — leaderboard + recent activity + who owes pizza.
- **Pizza Payment** — admins confirm a party was paid (fulfills the event).
- **Settings** — profile, change password, theme (light/dark/system), notification toggles, logout.

## 🏗️ Architecture

```
lib/
├── config/        # base URL + strike threshold
├── theme/         # light & dark ThemeData + semantic colors (ThemeExtension)
├── models/        # plain Dart models with fromJson (no codegen)
├── services/      # ApiClient (Dio + JWT refresh) + one service per domain
├── state/         # AuthProvider + SettingsProvider (ChangeNotifier)
├── widgets/       # logo, strike meter, buttons, cards, async views
├── screens/       # auth, employee/, admin/, settings, notifications
├── app.dart       # MaterialApp + providers + theme wiring
└── main.dart      # bootstrap
```

- **Auth:** access + refresh tokens stored with `flutter_secure_storage`; the
  API client auto-refreshes once on a 401 and retries, or drops to login.
- **No build_runner** required — just `flutter pub get`.

## ⚠️ Notes & limitations

- **Register** always creates an *employee* (admins are provisioned by an
  existing admin via the admin tools), matching the backend.
- The login/register **role toggle** is a UI hint; the real role comes from the
  server after authentication.
- **Photo upload** on the pizza-payment screen is a placeholder — the backend's
  fulfill endpoint accepts notes only, so the date/notes are sent and the photo
  box is cosmetic.
- **Notification preferences** in Settings are stored locally (the backend
  doesn't persist per-user preferences).
- **Team Status** uses the admin dashboard endpoints and is part of the admin
  experience.

Built to pair with the Pizza Striker FastAPI backend. Happy striking — and don't
forget the pizza! 🍕
