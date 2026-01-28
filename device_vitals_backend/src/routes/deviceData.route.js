const express = require("express");
const router = express.Router();
const {addDeviceVitals,getDeviceVitalsController,getAnalyticsController} = require('../controllers/deviceData.controller');

/**
 * @swagger
 * /api/vitals:
 *   post:
 *     summary: Add device vitals
 *     tags: [Device Vitals]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/DeviceVitals'
 *           example:
 *             device_id: "device-123"
 *             timestamp: "2024-01-15T10:30:00.000Z"
 *             thermal_value: 1.5
 *             battery_level: 85
 *             memory_usage: 45
 *     responses:
 *       201:
 *         description: Device vitals added successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Device vitals added successfully"
 *       400:
 *         description: Validation error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *             example:
 *               message: "Validation failed"
 *               errors: ["device_id is required", "timestamp must be in ISO format"]
 *       500:
 *         description: Internal server error
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Internal server error"
 */
router.post("/",addDeviceVitals)

/**
 * @swagger
 * /api/vitals/analytics/{id}:
 *   get:
 *     summary: Get device vitals analytics
 *     tags: [Device Vitals]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: Device ID
 *         example: "device-123"
 *       - in: query
 *         name: date_range
 *         required: true
 *         schema:
 *           type: string
 *           enum: [24hrs, 3days, 7days, 14days, 30days]
 *         description: Date range for analytics (24hrs, 3days, 7days, 14days, or 30days)
 *         example: "7days"
 *     responses:
 *       200:
 *         description: Analytics data retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AnalyticsResponse'
 *             example:
 *               device_id: "device-123"
 *               time_range:
 *                 from: "2024-01-21T10:30:00.000Z"
 *                 to: "2024-01-28T10:30:00.000Z"
 *               summary:
 *                 total_records: 100
 *                 last_updated: "2024-01-28T10:30:00.000Z"
 *               metrics:
 *                 thermal:
 *                   average: 1.5
 *                   rolling_average: 1.6
 *                   min: 0.8
 *                   max: 2.2
 *                 battery:
 *                   average: 85
 *                   rolling_average: 86
 *                   min: 70
 *                   max: 100
 *                 memory:
 *                   average: 45
 *                   rolling_average: 46
 *                   min: 30
 *                   max: 60
 *               series:
 *                 - timestamp: "2024-01-21T10:30:00.000Z"
 *                   thermal_value: 1.5
 *                   battery_level: 85
 *                   memory_usage: 45
 *       400:
 *         description: Bad request
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "device_id is required"
 *       404:
 *         description: No data found
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "No data found for the given device and date range"
 *       500:
 *         description: Internal server error
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Internal server error"
 */
router.get("/analytics/:id",getAnalyticsController)

/**
 * @swagger
 * /api/vitals/{id}:
 *   get:
 *     summary: Get device vitals by device ID
 *     tags: [Device Vitals]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: Device ID
 *         example: "device-123"
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           minimum: 1
 *           default: 1
 *         description: Page number for pagination
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           minimum: 1
 *           maximum: 100
 *           default: 10
 *         description: Number of records per page
 *     responses:
 *       200:
 *         description: Device vitals fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Device vitals fetched successfully"
 *                 pagination:
 *                   $ref: '#/components/schemas/Pagination'
 *                 data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/DeviceVitalsResponse'
 *       400:
 *         description: Bad request
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "device_id param is required"
 *       404:
 *         description: No device vitals found
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "No device vitals found for the given device_id"
 *       500:
 *         description: Internal server error
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Internal server error"
 */
router.get("/:id",getDeviceVitalsController)

module.exports = router;