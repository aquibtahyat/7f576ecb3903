# Device Vitals Flutter App

A Flutter mobile application that monitors device sensor data (thermal state, battery level, and memory usage) using native platform APIs and syncs with a backend service.

## 📋 Table of Contents

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

## 🎯 Overview

Device Vitals is a Flutter application that:
- Retrieves device sensor data using native MethodChannels (Android Kotlin / iOS Swift)
- Displays real-time sensor readings on a dashboard
- Logs sensor data to a backend API
- Shows historical data with pagination
- Provides analytics with charts and trends
- Supports best-effort background sync of cached logs
- Handles offline scenarios with local caching

## ✨ Features

### Core Features
- ✅ **Real-time Sensor Monitoring**
  - Thermal state (0-3 scale)
  - Battery level (0-100%)
  - Memory usage (0-100%)

- ✅ **Dashboard Screen**
  - Live sensor readings with visual indicators
  - Pull-to-refresh functionality
  - Manual logging button with feedback

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
  - PlatformException from native sensors: Snackbar with platform message
  - Network timeouts: Dio connect/receive timeout 30s; timeout errors shown in Snackbar
  - Graceful degradation (e.g. failed sensors show retry; failed log cached for offline sync)

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

- **Flutter SDK**: 3.9.0 or higher
- **Dart SDK**: 3.9.0 or higher
- **Android Studio** (for Android development)
  - Android SDK 21+ (Android 5.0+)
  - Kotlin support
- **Xcode** (for iOS development, macOS only)
  - iOS 12.0+
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

**Minimum iOS**: 12.0

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
- `THERMAL_STATUS_SEVERE` → 3

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
- **device_info_plus**: Device ID only (Android ID / iOS `identifierForVendor`). Sensor data (thermal, battery, memory) comes from MethodChannels, not this package.

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

- **Storage**: Device vitals logs cached locally
- **Sync**: Automatic sync when backend is available
- **Box Name**: `logBox`

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

## 📱 App Screenshots

### Dashboard Screen
- Real-time sensor readings
- Visual indicators for each metric
- Log button with feedback

### History Screen
- Fetches latest 100 entries from GET /api/vitals/:id
- Card-based UI with thermal label, battery %, memory % per entry
- Pull-to-refresh and app bar refresh; timestamp display

### Analytics Screen
- Interactive charts
- Date range selector
- Metrics display (min/max/avg)

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
