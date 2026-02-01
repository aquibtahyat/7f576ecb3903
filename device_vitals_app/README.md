# Device Vitals Flutter App

A Flutter mobile application that monitors device vitals (thermal state, battery level, and memory usage) using native platform APIs and syncs with a backend service.

## 📋 Table of Contents

- [App Screenshots](#-app-screenshots)
- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Running the App](#running-the-app)
- [Project Structure](#project-structure)
- [Native Platform Integration](#native-platform-integration)
- [State Management](#state-management)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)

## 📱 App Screenshots

<p align="center">
  <img src="https://private-user-images.githubusercontent.com/123585282/543427295-0657ae87-699d-40a0-8b05-10e96b87f5fe.jpg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk5NTMxNjAsIm5iZiI6MTc2OTk1Mjg2MCwicGF0aCI6Ii8xMjM1ODUyODIvNTQzNDI3Mjk1LTA2NTdhZTg3LTY5OWQtNDBhMC04YjA1LTEwZTk2Yjg3ZjVmZS5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMjAxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDIwMVQxMzM0MjBaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0zMjFkOWExNzY0M2FlYThjY2M5Yjg4MjQ5Y2RkMGIxOTM1ZmRjN2FmYWMxOWE0MGEzZTA1ZWVhMGQyMDQzNGE3JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.AHz2ohz1lkC6M8uJWYhEeEQ7UJe6RCsQO6lzL6SHqDc" width="220" alt="Screenshot 1" />
  <img src="https://private-user-images.githubusercontent.com/123585282/543427347-68f331a6-fffa-42a7-89c8-ad5b48655c1d.jpg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk5NTMyMzksIm5iZiI6MTc2OTk1MjkzOSwicGF0aCI6Ii8xMjM1ODUyODIvNTQzNDI3MzQ3LTY4ZjMzMWE2LWZmZmEtNDJhNy04OWM4LWFkNWI0ODY1NWMxZC5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMjAxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDIwMVQxMzM1MzlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xYmFlYTg3MTZmNTg1ZTY1ZGM0NmYwYjZiMTYyMzI3YjkyY2U0MGY5Y2VmZjRhN2I4N2MzZjYxOTA0NTdlYmNhJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.t4CSmmTTl6wCimWYRv_h4QgESiAwR3YHpWm9qf_Ryto" width="220" alt="Screenshot 2" />
  <img src="https://private-user-images.githubusercontent.com/123585282/543427371-28b6f0c4-9f74-47d6-99ab-ed402b440d6c.jpg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk5NTMyNTcsIm5iZiI6MTc2OTk1Mjk1NywicGF0aCI6Ii8xMjM1ODUyODIvNTQzNDI3MzcxLTI4YjZmMGM0LTlmNzQtNDdkNi05OWFiLWVkNDAyYjQ0MGQ2Yy5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMjAxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDIwMVQxMzM1NTdaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT05ZjFlYTE3NjFkZTNhOGVlZDlhMzU1ODYxZmJmM2FhZmJiYzU0NTkzNTc1MjUxMjVjYWViYzdmNjQ4M2UyMjcyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.4RE5r1gRgiuhXMp6maNSF-sET5facQmcoI7n62EVrZY" width="220" alt="Screenshot 3" />
  <img src="https://private-user-images.githubusercontent.com/123585282/543427427-8c748bc0-27a6-4785-bbf8-ec05d89a3a48.jpg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk5NTMyNzUsIm5iZiI6MTc2OTk1Mjk3NSwicGF0aCI6Ii8xMjM1ODUyODIvNTQzNDI3NDI3LThjNzQ4YmMwLTI3YTYtNDc4NS1iYmY4LWVjMDVkODlhM2E0OC5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMjAxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDIwMVQxMzM2MTVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yMjkxYjI3MWE0ZmVjNjQ4NGM1YmYwMmZkMDQ0NzkwZmZhMGM5MTJiNTc4NjQyYjRmMDA1ZTlkNDQ2OTVkOTk3JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.0eSZiHp1gQwCEKHyhs9LUyG-wEo65MChrpqvOdc_Nl0" width="220" alt="Screenshot 4" />
</p>
<p align="center">
  <img src="https://private-user-images.githubusercontent.com/123585282/543427465-a3737c5a-7308-4ca4-94ad-21aedd6dc66a.jpg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk5NTMyOTMsIm5iZiI6MTc2OTk1Mjk5MywicGF0aCI6Ii8xMjM1ODUyODIvNTQzNDI3NDY1LWEzNzM3YzVhLTczMDgtNGNhNC05NGFkLTIxYWVkZDZkYzY2YS5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMjAxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDIwMVQxMzM2MzNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01MjA5YWZlMzZjMDU5NDc5MTI4MWNkNDQ4MDQzYWNiYzA3ODc1NGE0YmU2MjNhNjYxYjQ1ZTA2NjFlYWU4MmZlJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.p9DlCENsLExRBgQaq8zwJ2SJOgjHMXVuhBNNgZpXjDk" width="220" alt="Screenshot 5" />
  <img src="https://private-user-images.githubusercontent.com/123585282/543427476-b3482168-c497-4fd3-afba-158ef5728963.jpg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk5NTMwMzYsIm5iZiI6MTc2OTk1MjczNiwicGF0aCI6Ii8xMjM1ODUyODIvNTQzNDI3NDc2LWIzNDgyMTY4LWM0OTctNGZkMy1hZmJhLTE1OGVmNTcyODk2My5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMjAxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDIwMVQxMzMyMTZaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT05NjRiY2Q3ZWZiMDQ5ZWFmNzZhMzcwMmM3NjY0MDQ2YzQyMTAxMjRhOWM0NzlhZWYyNTFhOWQ0Nzc4NGU4YjBiJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.INKAZeAnzd7i3X4BS6OFxfYJGG2Tw2fW1xTW7UNeegs" width="220" alt="Screenshot 6" />
  <img src="https://private-user-images.githubusercontent.com/123585282/543427529-a3bcac43-dbac-44bd-ac70-c15769ce95d7.jpg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk5NTM1NzIsIm5iZiI6MTc2OTk1MzI3MiwicGF0aCI6Ii8xMjM1ODUyODIvNTQzNDI3NTI5LWEzYmNhYzQzLWRiYWMtNDRiZC1hYzcwLWMxNTc2OWNlOTVkNy5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMjAxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDIwMVQxMzQxMTJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1hY2Q4Mjk1OTI0YzViNjdiYzA0YjU1MmI4ZGVkYTcwZmVkN2U2ZDczNGYwMzA4NTIzMWE2NTgzM2Q5NGZmNWUyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.gPOcz3_dAgj4D1cArX5Qdb5SIUC_Hdpt6RzUgHA8XfU" width="220" alt="Screenshot 7" />
  <img src="https://private-user-images.githubusercontent.com/123585282/543427545-13f27cbd-a576-4a04-a198-e3def8d30195.jpg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk5NTM2NDUsIm5iZiI6MTc2OTk1MzM0NSwicGF0aCI6Ii8xMjM1ODUyODIvNTQzNDI3NTQ1LTEzZjI3Y2JkLWE1NzYtNGEwNC1hMTk4LWUzZGVmOGQzMDE5NS5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjYwMjAxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI2MDIwMVQxMzQyMjVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iZGM0OWI2YjAxMDgyN2QwNTMxZmQ5MTAxNjg3NzJjOWI2NTkwM2FjNGQ0YzEwMmE2NjA5NDQ2OWY1NzFhNGY5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.5PCkf5mtuFKV0G45ky1H09Gb6SbYs62uREBcvMo9fQA" width="220" alt="Screenshot 8" />
</p>

## 🎯 Overview

Device Vitals is a Flutter application that:
- Retrieves device vitals (thermal state, battery level, memory usage) using native MethodChannels (Android Kotlin / iOS Swift)
- Displays current vitals on a dashboard
- Logs vitals data to a backend API
- Shows historical data with pagination
- Provides analytics with charts and trends
- Supports best-effort background sync of cached logs
- Handles offline scenarios with local caching

## ✨ Features

### Core Features
- ✅ **Device Vitals**
  - Thermal state (0-3 scale)
  - Battery level (0-100%)
  - Memory usage (0-100%)

- ✅ **Dashboard Screen**
  - Current vitals with visual indicators
  - Pull-to-refresh functionality
  - Manual logging button with feedback
  - Auto-log switch: user can enable/disable foreground auto-log; preference is persisted (Hive) and survives app restarts
  - When auto-log is on, vitals are logged automatically at a fixed interval while the app is in foreground

- ✅ **History Screen**
  - Fetches historical logs from GET /api/vitals (latest 100 entries per device)
  - User-friendly card-based UI with thermal label, battery %, memory %
  - Pull-to-refresh and refresh button
  - Timestamp formatting

- ✅ **Analytics Screen**
  - Interactive charts (Syncfusion)
  - Rolling averages and trends
  - Multiple date range options (24hrs, 3days, 7days, 14days, 30days)
  - Min/Max/Average metrics

- ✅ **Background Services**
  - Best-effort background upload/sync of cached logs (Android WorkManager)
  - Offline caching with Hive
  - Automatic sync when online

- ✅ **Error Handling**
  - Backend unreachable: Snackbar with user-friendly message (DioErrorHandler)
  - PlatformException from native platform APIs: Snackbar with platform message
  - Network timeouts: Dio connect/receive timeout 30s; timeout errors shown in Snackbar
  - Graceful degradation (e.g. failed vitals fetch shows retry; failed log cached for offline sync)

## 🏗️ Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── src/
│   ├── core/                          # Core utilities and services
│   │   ├── constants/                 # App constants, API endpoints
│   │   ├── injection/                 # Dependency injection (Injectable)
│   │   ├── network/                   # Dio configuration, interceptors
│   │   ├── routes/                    # GoRouter configuration
│   │   ├── services/                  # Background services, cache manager
│   │   └── theme/                     # App theme and colors
│   │
│   └── features/
│       └── device_vitals/
│           ├── data/                   # Data layer
│           │   ├── data_sources/      # Remote, Platform, Local (Hive)
│           │   ├── models/            # Data models
│           │   ├── repositories/      # Repository implementations
│           │   └── hive/              # Hive models for caching
│           │
│           ├── domain/                 # Business logic layer
│           │   ├── entities/          # Domain entities
│           │   ├── repositories/      # Repository interfaces
│           │   └── use_cases/         # Business use cases
│           │
│           └── presentation/           # UI layer
│               ├── manager/            # BLoC/Cubit state management
│               ├── pages/              # Screen widgets
│               └── widgets/            # Reusable UI components
│
├── app.dart                            # Root app widget
└── main.dart                           # Entry point
```

### Architecture Layers

1. **Presentation Layer**: UI components, BLoC/Cubit state management
2. **Domain Layer**: Business logic, entities, use cases
3. **Data Layer**: Data sources (remote, platform, local), repositories

## 📦 Prerequisites

- **Flutter SDK**: 3.35.0
- **Dart SDK**: 3.9.0 or higher
- **Android Studio** (for Android development)
  - Android SDK 21+ (Android 5.0+)
  - Kotlin support
- **Xcode** (for iOS development, macOS only)
  - iOS 14.0+
  - Swift support
- **Backend API**: Running instance (see [Backend README](../device_vitals_backend/README.md))

### Verify Flutter Installation

```bash
flutter doctor
```

Ensure all required components are installed and configured.

## 🔧 Installation

1. **Navigate to the app directory**
   ```bash
   cd device_vitals_app
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (for code generation)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Configure API endpoint** (see [Configuration](#configuration))

## ⚙️ Configuration

### API Endpoint Configuration

Update the API base URL in `lib/src/core/constants/api_endpoints.dart` to point to your backend—either the **deployed** API (Render) or a **local** server:

```dart
class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = 'https://sevenf576ecb3903.onrender.com';
}
```

This project uses the backend deployed on Render at `https://sevenf576ecb3903.onrender.com`. For local development, change `baseUrl` to a local URL (see below).

**For local development:**
- Android Emulator: `http://10.0.2.2:4000`
- iOS Simulator: `http://localhost:4000`
- Physical Device: `http://<your-computer-ip>:4000`

### Platform-Specific Configuration

#### Android

**Minimum SDK**: 21 (Android 5.0)

**Permissions** (already configured in `AndroidManifest.xml`):
- Battery monitoring (handled automatically)
- Internet access

#### iOS

**Minimum iOS**: 14.0

**Info.plist** (already configured):
- Battery monitoring enabled
- Background modes configured

## 🚀 Running the App

### Development Mode

```bash
flutter run
```

### Run on Specific Platform

**Android:**
```bash
flutter run -d android
```

**iOS:**
```bash
flutter run -d ios
```

### Run on Specific Device

List available devices:
```bash
flutter devices
```

Run on specific device:
```bash
flutter run -d <device-id>
```

### Release Build

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📱 Platform Support

### Android ✅

**Implementation**: Kotlin in `android/app/src/main/kotlin/`

**Native APIs Used**:
- `PowerManager.getCurrentThermalStatus()` and `PowerManager.getThermalHeadroom()`
- `BatteryManager.BATTERY_PROPERTY_CAPACITY`
- `ActivityManager.MemoryInfo`

**Thermal Status Mapping**:
- `THERMAL_STATUS_NONE` → 0
- `THERMAL_STATUS_LIGHT` → 1
- `THERMAL_STATUS_MODERATE` → 2
- `THERMAL_STATUS_SEVERE`, `THERMAL_STATUS_CRITICAL`, `THERMAL_STATUS_EMERGENCY`, `THERMAL_STATUS_SHUTDOWN` → 3

### iOS ✅

**Implementation**: Swift in `ios/Runner/AppDelegate.swift`

**Native APIs Used**:
- `ProcessInfo.processInfo.thermalState`
- `UIDevice.current.batteryLevel`
- `mach_task_basic_info` for memory

**Thermal State Mapping**:
- `nominal` → 0
- `fair` → 1
- `serious` → 2
- `critical` → 3

## 🔌 MethodChannel Integration

The app uses Flutter MethodChannels to communicate with native code:

**Channel Name**: `com.example.device_vitals`

**Methods**:
- `getThermalStatus` → Returns thermal state (0-3)
- `getBatteryLevel` → Returns battery level (0-100)
- `getMemoryUsage` → Returns memory usage (0-100)

**Usage Example**:
```dart
final channel = MethodChannel('com.example.device_vitals');
final batteryLevel = await channel.invokeMethod<int>('getBatteryLevel');
```

## 🎨 State Management

The app uses **BLoC (Business Logic Component)** pattern with Cubits:

### State Management Structure

- **Cubits**: Lightweight state management for simple state
- **BLoC**: For complex state with streams

### Key Cubits

- `GetThermalStateCubit` - Manages thermal state
- `GetBatteryLevelCubit` - Manages battery level
- `GetMemoryUsageCubit` - Manages memory usage
- `LogDeviceVitalsCubit` - Handles logging to API
- `GetHistoryCubit` - Manages history data
- `GetAnalyticsCubit` - Manages analytics data
- `AutoLogPreferenceCubit` - Manages user preference for auto-log (get/set); persisted via repository (Hive)
- `AutoLogTimerCubit` - Foreground timer that triggers auto-log at interval when auto-log is enabled

### State Flow

```
UI Widget → Cubit → Use Case → Repository → Data Source → API/Platform
                ↓
            State Update
                ↓
            UI Rebuild
```

## 🧪 Testing

### Run Unit Tests

```bash
flutter test
```

### Run Tests for Specific File

```bash
flutter test test/path/to/test_file.dart
```

### Test Coverage

```bash
flutter test --coverage
```

### Test Structure

Tests are located in the `test/` directory:
- Unit tests for repositories
- Unit tests for use cases
- Widget tests (optional)

## 📦 Dependencies

### Key Dependencies

- **go_router**: Navigation and routing
- **flutter_bloc**: State management
- **dio**: HTTP client
- **retrofit**: Type-safe REST client
- **injectable**: Dependency injection
- **hive_ce**: Local storage
- **workmanager**: Background tasks
- **syncfusion_flutter_charts**: Charts and graphs
- **device_info_plus**: Device ID only (Android ID / iOS `identifierForVendor`). Vitals (thermal, battery, memory) come from MethodChannels, not this package.

### Code Generation

The project uses code generation for:
- **Injectable**: Dependency injection
- **Retrofit**: API client generation
- **Hive**: Model adapters
- **JSON Serializable**: JSON serialization

**Regenerate code after changes:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🔄 Background Services

The app implements best-effort background syncing of cached logs using WorkManager (Android):

- **Frequency**: Periodic (best-effort; scheduling is OS-managed)
- **Trigger**: Network connectivity required
- **Storage**: Hive for offline caching
- **Sync**: Automatic when online

**Configuration** (in `main.dart`):
```dart
await Workmanager().registerPeriodicTask(
  'vitals-sync-periodic',
  'vitalsSyncTask',
  frequency: const Duration(minutes: 15),
  constraints: Constraints(networkType: NetworkType.connected),
);
```

## 💾 Offline Support

The app uses **Hive** for local caching:

- **Storage**: Device vitals logs cached locally; user preference for auto-log (on/off) and device unique ID are persisted in Hive via `CacheManager`
- **Sync**: Automatic sync when backend is available
- **Boxes**: Two Hive boxes—`logBox` (cached vitals logs) and `deviceBox` (unique ID, auto-log preference)

**Cache Flow**:
1. Log created → Stored in Hive
2. Attempt to send to API
3. If successful → Mark as synced
4. If failed → Keep in cache for retry

## 🐛 Troubleshooting

### Build Errors

**Error**: `Could not resolve all files for configuration`

**Solution**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### MethodChannel Errors

**Error**: `PlatformException` or `MethodChannel not found`

**Solutions**:
1. Verify native code is properly registered
2. Check method channel name matches (`com.example.device_vitals`)
3. Ensure platform-specific code is compiled
4. For Android: Rebuild the app
5. For iOS: Run `pod install` in `ios/` directory

### API Connection Errors

**Error**: `SocketException` or connection timeout

**Solutions**:
1. Verify backend is running
2. Check API base URL in `api_endpoints.dart`
3. For Android emulator, use `10.0.2.2` instead of `localhost`
4. For physical device, use your computer's IP address
5. Check firewall settings

### iOS Build Issues

**Error**: CocoaPods errors

**Solution**:
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
flutter run
```

### Hive Initialization Errors

**Error**: `HiveError` or box not found

**Solution**:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Background Task Not Working

**Issues**:
- Background tasks may not work in debug mode
- Test on release build or physical device
- Ensure proper permissions are granted

## 🔒 Permissions

### Android
- **Battery**: Handled automatically by Android system
- **Internet**: Required for API calls
- **Background**: Required for periodic logging

### iOS
- **Battery Monitoring**: Enabled in Info.plist
- **Background Modes**: Configured for background fetch

## 📝 Development Notes

### Code Generation

After modifying:
- Models with `@JsonSerializable`
- Repositories with `@injectable`
- Hive models
- Retrofit interfaces

Run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Dependency Injection

Uses `injectable` + `get_it`:
- Register dependencies in `injector.config.dart`
- Annotate classes with `@injectable`, `@lazySingleton`, etc.
- Access via `injector.get<Type>()`

### API Client

Uses `retrofit` + `dio`:
- Define interfaces in `remote_data_source.dart`
- Annotate with `@RestApi()`, `@GET()`, `@POST()`
- Generate implementation with build_runner

## 🚀 Deployment

### Android

1. **Generate signing key**:
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. **Configure signing** in `android/app/build.gradle`

3. **Build release APK**:
   ```bash
   flutter build apk --release
   ```

4. **Build App Bundle**:
   ```bash
   flutter build appbundle --release
   ```

### iOS

1. **Configure signing** in Xcode
2. **Build for release**:
   ```bash
   flutter build ios --release
   ```
3. **Archive and upload** via Xcode

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [BLoC Pattern](https://bloclibrary.dev/)
- [MethodChannel Guide](https://docs.flutter.dev/platform-integration/platform-channels)
- [WorkManager Plugin](https://pub.dev/packages/workmanager)
- [Hive Documentation](https://docs.hivedb.dev/)

## 🤝 Contributing

This is a take-home assignment project. For questions or issues, refer to:
- [Main README](../README.md)
- [DECISIONS.md](../DECISIONS.md)
- [ai_log.md](../ai_log.md)

---

**Note**: Ensure the backend API is running before testing the app. See [Backend README](../device_vitals_backend/README.md) for backend setup instructions.
