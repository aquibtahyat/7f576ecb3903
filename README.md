# Device Vitals Monitor

A full-stack mobile application that monitors device vitals (thermal state, battery level, and memory usage) and logs them to a backend service with analytics capabilities.

## 🎯 Overview

Device Vitals Monitor consists of:

- **Flutter Mobile App**: Retrieves device vitals (thermal state, battery level, memory usage) using native platform APIs (Android Kotlin / iOS Swift) via MethodChannels, displays current readings on the dashboard, and syncs with the backend
- **Node.js Backend API**: RESTful API with MongoDB persistence, data validation, and analytics endpoints

## ✨ Key Features

- ✅ Device vitals monitoring (thermal state, battery level, memory usage)
- ✅ Native platform integration via MethodChannels (Android & iOS) — no 3rd-party packages for vitals
- ✅ RESTful API backend with persistent MongoDB storage
- ✅ Data validation: thermal 0–3, battery/memory 0–100, ISO timestamp, future timestamps rejected
- ✅ Analytics screen with rolling averages, min/max, and charts (GET /api/vitals/analytics/:id)
- ✅ History screen: latest 100 entries from GET /api/vitals/:id
- ✅ Background logging every 15 minutes (bonus)
- ✅ Offline support with local caching (Hive) (bonus)
- ✅ Comprehensive error handling (backend unreachable, PlatformException, timeouts)

## 🛠️ Tech Stack

**Mobile App:**
- Flutter 3.35.0 with BLoC state management
- Local Storage: Hive
- Background Tasks: WorkManager

**Backend:**
- Node.js with Express.js
- MongoDB with Mongoose
- Swagger API documentation
- Jest for testing

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.35.0
- Node.js 18.x+
- MongoDB 6.0+

### Getting Started

For detailed installation and setup instructions, please refer to:
- 📖 **[Backend Setup Guide →](./device_vitals_backend/README.md#installation)**
- 📖 **[Mobile App Setup Guide →](./device_vitals_app/README.md#installation)**

### Deployed Backend

The backend is deployed on [Render](https://render.com) at **https://sevenf576ecb3903.onrender.com**. The Flutter app is configured with this base URL so it talks to the live backend. For local development, change the base URL in the app (see [App Configuration →](./device_vitals_app/README.md#api-endpoint-configuration)).

## 📁 Project Structure

```
.
├── device_vitals_app/          # Flutter mobile application
│   └── README.md               # Mobile app documentation
├── device_vitals_backend/      # Node.js backend API
│   └── README.md               # Backend documentation
├── README.md                   # This file
├── DECISIONS.md               # Design decisions and ambiguity handling
└── ai_log.md                  # AI collaboration log
```

## 📱 Platform Support

- **Android**: ✅ Fully implemented (Kotlin, API 21+)
- **iOS**: ✅ Fully implemented (Swift, iOS 14.0+)

## 📚 Documentation

- **[Backend README](./device_vitals_backend/README.md)** - Complete backend setup, API documentation, endpoints, validation rules, and testing
- **[Mobile App README](./device_vitals_app/README.md)** - Complete Flutter app setup, architecture, MethodChannel integration, state management, and troubleshooting
- **[DECISIONS.md](./DECISIONS.md)** - Design decisions, ambiguity handling, and assumptions
- **[ai_log.md](./ai_log.md)** - AI collaboration workflow and prompts

## 🔗 API Documentation

The backend is deployed on [Render](https://render.com). Interactive Swagger documentation is available at:

- **Deployed (live):** https://sevenf576ecb3903.onrender.com/api-docs
- **Local:** http://localhost:4000/api-docs (when running the backend locally)

**Main Endpoints:**
- `POST /api/vitals` - Log device vitals (validates thermal 0–3, battery 0–100, memory 0–100, ISO timestamp, rejects future timestamps)
- `GET /api/vitals/:id` - Get device vitals history (paginated; default latest 100 entries)
- `GET /api/vitals/analytics/:id` - Get analytics data (rolling average, min/max, series; requires `date_range` query)

For detailed API documentation, see the [Backend README](./device_vitals_backend/README.md).

## 🧪 Testing

**Backend:**
```bash
cd device_vitals_backend
npm test
```

**Mobile App:**
```bash
cd device_vitals_app
flutter test
```

## 📝 Additional Information

This project was developed as a take-home assignment demonstrating:
- Full-stack mobile development (Flutter + Native)
- Backend API design and implementation
- Clean architecture and separation of concerns
- Error handling and data validation
- Background services and offline support

For detailed setup instructions, architecture explanations, and troubleshooting guides, please refer to the individual README files for each component.

---

**Need help?** Check the detailed documentation:
- 📱 [Mobile App Setup & Documentation](./device_vitals_app/README.md)
- 🔧 [Backend Setup & API Documentation](./device_vitals_backend/README.md)
