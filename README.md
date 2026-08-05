# Point Plus Merchant

Flutter project scaffold for the Point Plus merchant companion app (package name: `merchant`). The runnable entry point is still the default Flutter counter sample. `pubspec.yaml` declares a merchant-oriented stack including BLoC, maps, Firebase, secure storage, QR generation, and Shorebird.

## Features (current codebase)

- Runnable Flutter demo app (`lib/main.dart` counter sample)
- Asset folders present on disk: `assets/fonts/`, `assets/logo/`, `assets/loading/`
- Declared dependencies for GoRouter, flutter_bloc, Dio (with cookie manager), maps/geolocation, Firebase Messaging/Remote Config, flutter_secure_storage, qr_flutter, Shorebird, and `.env` loading
- Localization generation enabled (`flutter: generate: true`), but no `l10n/` directory or ARB files are present yet

## Tech Stack

- Flutter (Dart SDK `^3.9.0`; FVM pin in `.fvmrc`)
- Intended stack from `pubspec.yaml`: go_router, flutter_bloc/bloc, dio, cookie_jar, firebase_*, flutter_map, flutter_dotenv, shorebird_code_push, fpdart, equatable, qr_flutter

## Project Structure

```text
lib/
  main.dart                 # Default Flutter counter app (current entry)
assets/
  fonts/                    # Walone TTF files
  logo/
  loading/
android/ ios/ web/ macos/ linux/ windows/
```

`pubspec.yaml` also lists `assets/icons/` and `assets/images/`, but those directories are not on disk yet. `flutter: generate: true` is set without a `l10n/` tree or ARB files.

## Getting Started

### Prerequisites

- Flutter SDK matching `.fvmrc` / `sdk: ^3.9.0`
- Create a root `.env` when integrating dotenv-backed configuration

### Install and run

```bash
flutter pub get
flutter run
```

## Configuration

- `.env` is listed under Flutter assets; add local keys when wiring API clients.
- Firebase / Shorebird setup will be required once merchant features are implemented beyond the scaffold.

## Status

Early scaffold only: merchant feature modules are not present under `lib/` yet. The declared dependency set indicates planned rewards/merchant workflows (auth, maps, QR, push notifications), but those screens are not implemented in this snapshot.
