# Design Decisions & Ambiguity Handling

This document outlines: (1) each ambiguity with Question, Options Considered, Decision, Trade-offs, and Assumptions; (2) questions to ask the project manager; then requirements compliance and summary.

## Table of Contents

- [Ambiguity 1: Analytics Endpoint Response Format](#ambiguity-1-analytics-endpoint-response-format)
- [Ambiguity 2: Device ID and Device-Specific Data](#ambiguity-2-device-id-and-device-specific-data)
- [Ambiguity 3: Offline Support Strategy](#ambiguity-3-offline-support-strategy)
- [Ambiguity 4: Background Logging Failure Handling](#ambiguity-4-background-logging-failure-handling)
- [Ambiguity 5: How to Present History and Analytics](#ambiguity-5-how-to-present-history-and-analytics)
- [Ambiguity 6: Foreground Auto-Refresh and Auto-Log](#ambiguity-6-foreground-auto-refresh-and-auto-log)
- [Ambiguity 7: Sensor Failure Handling](#ambiguity-7-sensor-failure-handling)
- [Ambiguity 8: Database/Storage Technology Choice](#ambiguity-8-databasestorage-technology-choice)
- [Ambiguity 9: Date Range Options for Analytics](#ambiguity-9-date-range-options-for-analytics)
- [Questions to Ask the Project Manager](#questions-to-ask-the-project-manager)
- [Requirements Compliance Notes](#requirements-compliance-notes)
- [Summary](#summary)

---

## Ambiguity 1: Analytics Endpoint Response Format

**Question**: What specific analytics should be returned beyond rolling average?

**Options Considered**:
- Option A: Only rolling average (simple, meets literal requirement)
- Option B: Multiple metrics (min, max, average, trend direction)
- Option C: Time-windowed analytics with multiple date ranges and comprehensive metrics (last hour, day, week, etc.)

**Decision**: I chose Option C because users monitoring device health need context beyond just averages; min/max help identify anomalies; multiple date ranges (24hrs, 3days, 7days, 14days, 30days) provide flexibility; and time series data (downsampled) enables trend visualization and actionable insights.

**Trade-offs**: More complex response structure and larger payload; increased computation time (mitigated by downsampling). Acceptable for better analytics value.

**Assumptions**: Users want to understand device health trends over time; charts/graphs will be rendered on the client side; downsampling to 8 points is sufficient for visualization.

---

## Ambiguity 2: Device ID and Device-Specific Data

**Question**: Should history and analytics be device-specific (per device) or show all data? How should devices without a stable device ID be handled?

**Options Considered**:
- Option A: Global history/analytics (no device_id in GET); no special handling for missing device ID
- Option B: Device-specific history/analytics; require a device ID—devices without one cannot log
- Option C: Device-specific history/analytics; when the platform doesn't provide a device ID, generate a stable UUID, cache it locally, and use it as device_id

**Decision**: I chose Option C because per-device history fits a single-device app; the API already expects device_id in POST and supports per-device GET; and generating and caching a UUID ensures every install can log and fetch its own history and analytics.

**Trade-offs**: Devices without a platform ID share no identity across reinstalls (new install = new UUID). Acceptable for "this device's" data. Backend doesn't distinguish real vs generated device IDs. The device ID can be encrypted in future for privacy if required.

**Assumptions**: Users expect to see only their own device's history and analytics; it is better for devices without a native ID to have data under a generated ID than to be unable to log or view history/analytics.

---

## Ambiguity 3: Offline Support Strategy

**Question**: Should the app support offline logging? If the backend is unreachable, should logs be queued locally or discarded?

**Options Considered**:
- Option A: Discard logs when backend is unreachable, show error
- Option B: Queue logs locally, sync when online (simple queue)
- Option C: Queue logs locally with Hive, sync in background, retry failed logs
- Option D: Queue logs locally, sync on app foreground, manual retry

**Decision**: I chose Option C because it ensures no data loss; background sync gives seamless UX; automatic retry reduces manual intervention; Hive is fast local storage; and it aligns with the bonus requirement for offline support.

**Trade-offs**: Increased app complexity and local storage usage; background service overhead (15-minute intervals). Acceptable for better UX and no data loss.

**Assumptions**: Users expect data to be preserved even when offline; network connectivity issues are temporary; background sync is acceptable for this use case.

---

## Ambiguity 4: Background Logging Failure Handling

**Question**: When background logging fails, should we retry immediately or wait for the next interval? What happens to the failed log?

**Options Considered**:
- Option A: Discard failed log, wait for next interval
- Option B: Retry immediately with exponential backoff
- Option C: Cache failed log, retry on next background sync
- Option D: Cache failed log, retry on next sync, and also attempt to log current vitals

**Decision**: I chose Option D because it ensures no data loss; syncs both old and new data; and maximizes data collection even after failures.

**Trade-offs**: More complex background service logic; may accumulate logs if backend is down for extended period. Acceptable for data integrity.

**Assumptions**: Network failures are temporary; users expect automatic recovery; background service can handle both sync and new logging.

---

## Ambiguity 5: How to Present History and Analytics

**Question**: How should the app present historical logs (GET /api/vitals) and analytics (GET /api/vitals/analytics)? One screen with tabs, two screens, or a single combined view?

**Options Considered**:
- Option A: Single screen with tabs (History | Analytics) and switchable content
- Option B: Two separate screens with bottom navigation bar (Dashboard, History, Analytics)
- Option C: Single "History" screen that shows both list and analytics in one scrollable view
- Option D: Two screens with bottom nav, plus cards and dropdown/selector controls for better visibility and date-range selection

**Decision**: I chose Option D because two screens keep list and analytics clearly separated and match the two APIs; bottom nav gives quick access; and cards and date-range dropdown improve scanability and usability.

**Trade-offs**: More screens than a single-tab layout; dropdown adds one tap for date range. Acceptable for clearer separation of "what happened" vs "what it means."

**Assumptions**: Users benefit from separating "list of past logs" from "aggregated analytics and charts"; cards and dropdowns improve visibility and usability.

---

## Ambiguity 6: Foreground Auto-Refresh and Auto-Log

**Question**: Should the app auto-refresh dashboard data and auto-log vitals while in foreground? Should this be user-configurable?

**Options Considered**:
- Option A: No foreground auto-refresh or auto-log; user manually refreshes and taps "Log Status"
- Option B: Foreground timer that auto-refreshes and logs at an interval; no user control
- Option C: Foreground timer for auto-refresh and auto-log; scope for future user choice (e.g. auto-log switch)

**Decision**: I chose Option C because it keeps the dashboard current and builds history without requiring the user to tap "Log Status" every time; the timer runs only in foreground so it doesn't overlap with background WorkManager; and a user-configurable switch is a natural future step.

**Trade-offs**: Fixed interval (e.g. 10 min) for now; no UI for toggling auto-log yet. Documented as scope for future enhancement.

**Assumptions**: Users benefit from updated data and auto-log while the app is open; some users may prefer to disable auto-log later (switch would support that).

---

## Ambiguity 7: Sensor Failure Handling

**Question**: What happens when a sensor temporarily fails or returns unavailable data? Should the app fail completely, return default values, or require all sensors to log?

**Options Considered**:
- Option A: Fail completely, show error to user, don't log anything
- Option B: Return default values (e.g. 0 or -1) and log with a flag
- Option C: Return PlatformException, handle gracefully in UI; require all three sensors (thermal, battery, memory) to be available before allowing log—no partial logs
- Option D: Skip failed sensors, log only available data (partial logs; API would need to allow optional fields)

**Decision**: I chose Option C because it provides transparency about sensor availability; keeps analytics consistent (every log has thermal, battery, memory); prevents invalid data from skewing rolling average; and sensor unavailability is rare, so requiring all three is an acceptable tradeoff for data quality.

**Trade-offs**: Data quality over logging frequency—a user with one sensor unavailable cannot log until it's available again. More complex error handling; users see errors (but informative). Acceptable for data quality.

**Assumptions**: Users prefer transparency over silent failures; data quality is more important than logging frequency; sensor failures are rare; requiring all three sensors to log is an acceptable tradeoff.

---

## Ambiguity 8: Database/Storage Technology Choice

**Question**: Which storage solution should be used for persistence? SQLite, JSON file, embedded DB, or something else?

**Options Considered**:
- Option A: SQLite (lightweight, embedded, good for simple queries)
- Option B: JSON file with file locking (simple, no dependencies)
- Option C: MongoDB (scalable, flexible schema, better for analytics and time-series queries)
- Option D: LiteDB/LowDB (embedded, NoSQL-like)

**Decision**: I chose Option C because MongoDB provides better support for time-series and date-range queries needed for analytics; flexible schema for future extensions without migrations; indexing on device_id and timestamp for efficient queries; and Mongoose provides validation and type safety.

**Trade-offs**: Requires MongoDB installation; more complex setup than JSON file; external dependency. Acceptable for backend service and scalability.

**Assumptions**: This is a backend service that can have external dependencies; scalability and query performance matter; future features may require complex queries.

---

## Ambiguity 9: Date Range Options for Analytics

**Question**: What date range options should be available for analytics? Predefined only or custom picker?

**Options Considered**:
- Option A: Single fixed range (e.g. last 7 days)
- Option B: Predefined options (24hrs, 7days, 30days)
- Option C: Predefined options with more granularity (24hrs, 3days, 7days, 14days, 30days)
- Option D: Custom date range picker

**Decision**: I chose Option C because it provides flexibility without UI complexity; common time ranges for device monitoring; the 3-day option fills the gap between 24hrs and 7days; and it is a good balance between flexibility and simplicity.

**Trade-offs**: No custom date ranges; fixed options; requires backend filtering. Acceptable for simpler UX and most use cases.

**Assumptions**: Users prefer predefined ranges over custom pickers; these ranges cover most analysis needs; backend filtering is acceptable for performance.

---

## Questions to Ask the Project Manager

**Analytics**
- What specific insights are users looking for—overheating, battery degradation, memory leaks?
- Do users need to compare metrics across multiple devices?
- Should we alert users when metrics exceed thresholds?

**Device ID and data**
- Should device IDs be anonymized or hashed for privacy?
- Do we need authentication/authorization so users only see their own device(s)?
- Should users be able to delete their historical data?

**Offline**
- How long can the app be offline before data loss becomes unacceptable?
- Should users be notified when logs are queued offline?
- Is there a maximum number of queued logs before we need to warn users?

**Background logging**
- Is 15 minutes the optimal sync frequency, or should it be configurable?
- Should background logging respect battery optimization settings?
- What happens if the app is force-closed—should logging resume on next launch?

**History and Analytics UI**
- What's the primary use case—monitoring, debugging, or analytics?
- Should users be able to export data?
- Do we need dark mode or accessibility-specific layouts?

**Foreground auto-log**
- Should the foreground interval be configurable (e.g. 5 / 10 / 15 min)?
- Should we show an indicator when auto-log is active?
- Do we need to respect "low data" or battery-saver mode and reduce frequency?

**Sensor failure**
- How should we handle sensors that are permanently unavailable (e.g. on emulators)?
- Should we show different error messages for temporary vs permanent sensor failures?
- Do users need a way to manually retry failed operations?

**Database**
- Are there any existing database infrastructure constraints?
- Do we need to support read replicas or sharding?
- What's the expected data growth rate?

**Date range**
- Do we need custom date ranges (e.g. "from X to Y")?
- Should the default range be configurable per user?
- How long should historical data be retained on the backend?

**General**
- What's the expected number of concurrent devices/users? Should we implement rate limiting?
- Do we need authentication/authorization for the API?
- What level of test coverage is expected? Do we need integration tests with real devices?
- Should users be notified of critical sensor readings or background sync status?

---

## Requirements Compliance Notes

The following implementation details were added or clarified to align with the assignment's explicit requirements (not ambiguities):

### 1. Reject Future Timestamps

**Requirement**: "Reject future timestamps" (Data Validation).

**Implementation**: Backend validator (`deviceVitalsValidator.js`) uses `Joi.date().iso().max('now').required()` so any timestamp after "now" is rejected with message `"timestamp cannot be in the future"`. Unit tests in `deviceVitalsValidator.test.js` cover "reject future timestamp" and "accept past timestamp".

### 2. GET /api/vitals and "Latest 100 Entries"

**Requirement**: "GET /api/vitals - Return historical logs (latest 100 entries)".

**Implementation**: The API exposes **GET /api/vitals/:id** (per-device history) with pagination. Default `limit` is **100** (in `pagination.js`), so the first page returns the latest 100 entries for that device. This satisfies "latest 100 entries" while keeping a per-device API. The Flutter app calls this with default `limit: 100`.

### 3. Documentation

- **README (root, backend, app)**: Updated to describe current behaviour: future timestamp validation, history default limit 100, MethodChannels-only sensor data, error handling, and test coverage (including timestamp validation).
- **DECISIONS.md**: This document records ambiguities, assumptions, and questions per the requirement.
- **ai_log.md**: Post-review updates section added to record post-check changes.

---

## Summary

This project involved making several independent decisions due to ambiguous requirements. The key philosophy was:

1. **Prioritize data quality** over logging frequency
2. **Provide transparency** to users about system state
3. **Ensure no data loss** through offline support
4. **Balance simplicity with functionality** in analytics
5. **Choose scalable technologies** that support future growth

All decisions were made with the understanding that this is a device health monitoring system where **accuracy and reliability** are paramount, even if it means showing errors to users or requiring more complex implementations.

**Note**: In a real-world scenario, many of these decisions would be made collaboratively with product managers, designers, and other stakeholders. This document demonstrates the thought process and trade-off analysis that goes into engineering decisions when requirements are incomplete.
