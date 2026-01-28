require("dotenv").config();

const express = require('express')
const cors = require("cors")
const helmet = require("helmet")
const swaggerUi = require('swagger-ui-express')
const swaggerSpec = require('./src/configs/swagger')
const errorHandler = require('./src/middlewares/errorHandler.js')
const deviceVitalsRoute = require('./src/routes/deviceData.route')

const app = express();
app.use(express.json())
app.use(cors())
app.use(helmet());
const connectDB = require('./src/configs/database');
connectDB();

// Swagger documentation
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec, {
  customCss: '.swagger-ui .topbar { display: none }',
  customSiteTitle: 'Device Vitals API Documentation'
}));

app.use("/api/vitals",deviceVitalsRoute);

app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: "Route not found",
  });
});

app.use(errorHandler);

module.exports = app;