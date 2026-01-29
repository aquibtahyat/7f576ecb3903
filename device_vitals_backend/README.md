# Device Vitals Backend API

A Node.js/Express RESTful API for receiving, storing, and analyzing device sensor vitals data.

## 📋 Table of Contents

- [Overview](#overview)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Running the Server](#running-the-server)
- [API Endpoints](#api-endpoints)
- [Data Validation](#data-validation)
- [Database Schema](#database-schema)
- [Testing](#testing)
- [API Documentation](#api-documentation)
- [Error Handling](#error-handling)

## 🎯 Overview

This backend service provides a persistent API for:
- Receiving device vitals data (thermal state, battery level, memory usage)
- Storing data in MongoDB with validation
- Providing historical data retrieval with pagination
- Calculating analytics including rolling averages

## 🛠️ Tech Stack

- **Runtime**: Node.js 18.x+
- **Framework**: Express.js 5.x
- **Database**: MongoDB (via Mongoose)
- **Validation**: Joi
- **Documentation**: Swagger/OpenAPI (swagger-jsdoc, swagger-ui-express)
- **Security**: Helmet, CORS
- **Testing**: Jest
- **Development**: Nodemon

## 🏗️ Architecture

```
src/
├── configs/
│   ├── database.js          # MongoDB connection
│   └── swagger.js           # Swagger/OpenAPI configuration
├── controllers/
│   └── deviceData.controller.js  # Request handlers
├── middlewares/
│   └── errorHandler.js     # Global error handler
├── models/
│   └── deviceVitals.model.js     # Mongoose schema
├── routes/
│   └── deviceData.route.js       # API routes
├── service/
│   └── deviceVitals.service.js   # Business logic
├── utils/
│   ├── dashboard.js         # Analytics calculations
│   └── pagination.js        # Pagination helpers
└── validations/
    └── deviceVitalsValidator.js  # Joi validation schemas
```

## 📦 Prerequisites

- Node.js 18.x or higher
- MongoDB 6.0 or higher (local or cloud instance)
- npm or yarn package manager

## 🔧 Installation

1. **Navigate to the backend directory**
   ```bash
   cd device_vitals_backend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   ```

4. **Configure environment variables** (see [Configuration](#configuration))

## ⚙️ Configuration

Create a `.env` file in the `device_vitals_backend` directory (see `.env.example`)

```env
DATABASE_URL=<your_mongodb_connection_string>
PORT=4000
NODE_ENV=development
```

### Environment Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `DATABASE_URL` | MongoDB connection string | - | Yes |
| `PORT` | Server port | 4000 | No |
| `NODE_ENV` | Environment (development/production) | development | No |

## 🚀 Running the Server

### Development Mode (with auto-reload)
```bash
npm run dev
```

### Production Mode
```bash
npm start
```

The server will start on `http://localhost:4000` (or the port specified in `.env`).

### Verify Server is Running

You should see:
```
MongoDB Connected: <host>
Server is Running on port 4000
```

## 📡 API Endpoints

### Base URL
```
http://localhost:4000/api/vitals
```

### 1. Log Device Vitals

**POST** `/api/vitals`

Logs device sensor data to the database.

**Request Body:**
```json
{
  "device_id": "device-123",
  "timestamp": "2024-01-15T10:30:00.000Z",
  "thermal_value": 1,
  "battery_level": 85,
  "memory_usage": 45
}
```

**Response (201 Created):**
```json
{
  "message": "Device vitals added successfully"
}
```

**Error Response (400 Bad Request):**
```json
{
  "message": "Validation failed",
  "errors": [
    "thermal_value must be a number",
    "battery_level cannot exceed 100",
    "timestamp cannot be in the future"
  ]
}
```

### 2. Get Device Vitals History

**GET** `/api/vitals/:id`

Retrieves historical device vitals with pagination.

**Path Parameters:**
- `id` (string, required): Device ID

**Query Parameters:**
- `page` (number, optional): Page number (default: 1)
- `limit` (number, optional): Records per page (default: 100, max: 100). Default returns latest 100 entries.

**Example:**
```
GET /api/vitals/device-123
GET /api/vitals/device-123?page=1&limit=100
```

**Response (200 OK):**
```json
{
  "message": "Device vitals fetched successfully",
  "pagination": {
    "totalRecords": 100,
    "currentPage": 1,
    "totalPages": 1,
    "limit": 100
  },
  "data": [
    {
      "timestamp": "2024-01-15T10:30:00.000Z",
      "thermal_value": 1,
      "battery_level": 85,
      "memory_usage": 45
    }
  ]
}
```

### 3. Get Device Analytics

**GET** `/api/vitals/analytics/:id`

Retrieves analytics data including rolling averages and trends.

**Path Parameters:**
- `id` (string, required): Device ID

**Query Parameters:**
- `date_range` (string, required): Time range for analytics
  - Options: `24hrs`, `3days`, `7days`, `14days`, `30days`

**Example:**
```
GET /api/vitals/analytics/device-123?date_range=7days
```

**Response (200 OK):**
```json
{
  "device_id": "device-123",
  "time_range": {
    "from": "2024-01-21T10:30:00.000Z",
    "to": "2024-01-28T10:30:00.000Z"
  },
  "summary": {
    "total_records": 100,
    "last_updated": "2024-01-28T10:30:00.000Z"
  },
  "metrics": {
    "thermal": {
      "average": 1.5,
      "rolling_average": 1.6,
      "min": 0,
      "max": 3
    },
    "battery": {
      "average": 85,
      "rolling_average": 86,
      "min": 70,
      "max": 100
    },
    "memory": {
      "average": 45,
      "rolling_average": 46,
      "min": 30,
      "max": 60
    }
  },
  "series": [
    {
      "timestamp": "2024-01-21T10:30:00.000Z",
      "thermal_value": 1.5,
      "battery_level": 85,
      "memory_usage": 45
    }
  ]
}
```

## ✅ Data Validation

The API validates all incoming data according to these rules:

### Thermal Value
- **Type**: Number
- **Range**: 0-3 (inclusive)
- **Mapping**:
  - 0: None/Nominal
  - 1: Light/Fair
  - 2: Moderate/Serious
  - 3: Severe/Critical

### Battery Level
- **Type**: Number
- **Range**: 0-100 (inclusive)
- **Unit**: Percentage

### Memory Usage
- **Type**: Number
- **Range**: 0-100 (inclusive)
- **Unit**: Percentage

### Timestamp
- **Type**: ISO 8601 datetime string
- **Format**: `YYYY-MM-DDTHH:mm:ss.sssZ`
- **Validation**: Cannot be in the future

### Device ID
- **Type**: String
- **Required**: Yes
- **Cannot be empty**

## 🗄️ Database Schema

### DeviceVitals Collection

```javascript
{
  id: String (UUID, unique),
  device_id: String (required),
  timestamp: Date (required),
  thermal_value: Number (0-3, required),
  battery_level: Number (0-100, required),
  memory_usage: Number (0-100, required),
  createdAt: Date (auto),
  updatedAt: Date (auto)
}
```

### Indexes
- `device_id` - Indexed for faster queries
- `timestamp` - Indexed for time-based queries
- `id` - Unique index

## 🧪 Testing

### Run Tests
```bash
npm test
```

### Run Tests in Watch Mode
```bash
npm run test:watch
```

### Generate Coverage Report
```bash
npm run test:coverage
```

### Test Coverage

The test suite includes:
- ✅ Data validation tests (thermal 0–3, battery 0–100, memory 0–100)
- ✅ Rolling average calculation tests (last 3 values)
- ✅ Timestamp validation (future timestamp rejected, past timestamp accepted)
- ✅ Missing required field validation
- ✅ Pagination logic (default limit 100)

## 📖 API Documentation

Interactive API documentation is available via Swagger UI:

```
http://localhost:4000/api-docs
```

The Swagger documentation includes:
- All available endpoints
- Request/response schemas
- Example requests
- Error responses

## 🚨 Error Handling

The API uses a centralized error handler middleware that:

1. **Validation Errors (400)**
   - Returns detailed error messages for invalid input
   - Lists all validation failures

2. **Not Found (404)**
   - Returns when device ID not found
   - Returns when no data matches query criteria

3. **Server Errors (500)**
   - Logs error details to console
   - Returns generic error message to client
   - Prevents sensitive information leakage

### Error Response Format

```json
{
  "message": "Error description",
  "errors": ["Detailed error 1", "Detailed error 2"]
}
```

## 🔒 Security Features

- **Helmet.js**: Sets security HTTP headers
- **CORS**: Configurable cross-origin resource sharing
- **Input Validation**: All inputs validated before processing
- **Error Sanitization**: Errors don't expose internal details
- **Environment Variables**: Sensitive data stored in `.env`

## 📊 Performance Considerations

- **Database Indexing**: Indexed fields for faster queries
- **Pagination**: Limits data transfer for large datasets
- **Connection Pooling**: MongoDB connection pooling enabled
- **Efficient Queries**: Optimized database queries with proper filtering

## 🐛 Troubleshooting

### MongoDB Connection Issues

**Error**: `MongoDB connection error`

**Solutions**:
1. Verify MongoDB is running: `mongod --version`
2. Check connection string in `.env`
3. Ensure network connectivity
4. Verify MongoDB authentication credentials

### Port Already in Use

**Error**: `EADDRINUSE: address already in use`

**Solutions**:
1. Change `PORT` in `.env`
2. Kill process using the port:
   ```bash
   # Find process
   lsof -i :4000
   # Kill process
   kill -9 <PID>
   ```

### Validation Errors

**Error**: `Validation failed`

**Solutions**:
1. Check request body matches schema
2. Verify all required fields are present
3. Ensure data types are correct
4. Check value ranges (thermal: 0-3, battery/memory: 0-100)

## 📝 Development Notes

- The server uses MongoDB for persistence (survives restarts)
- All timestamps are stored in UTC
- Timestamps are validated: must be ISO 8601 and cannot be in the future
- Rolling average is calculated using the last 3 records per metric
- History endpoint defaults to 100 records per page (latest 100 entries), max 100

## 🚀 Deployment

This backend is deployed on **Render** at `https://sevenf576ecb3903.onrender.com`. After deployment:

1. Set `NODE_ENV=production`
2. Use MongoDB Atlas or a managed MongoDB service for `DATABASE_URL`
3. Configure CORS origins for your app's origin
4. Set up monitoring and logging
5. Enable rate limiting (optional)
6. The app's base URL is set to `https://sevenf576ecb3903.onrender.com` in the Flutter app (see [App README](../device_vitals_app/README.md#api-endpoint-configuration))

## 🔄 Next Steps

For production deployment:
1. Set `NODE_ENV=production`
2. Use MongoDB Atlas or managed MongoDB service
3. Configure proper CORS origins
4. Set up monitoring and logging
5. Enable rate limiting
6. Configure SSL/TLS

---

For questions or issues, please refer to the main [README.md](../README.md) or [DECISIONS.md](../DECISIONS.md).
