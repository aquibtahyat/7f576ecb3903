const swaggerJsdoc = require('swagger-jsdoc');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Device Vitals API',
      version: '1.0.0',
      description: 'API documentation for Device Vitals Management System',
      contact: {
        name: 'API Support',
      },
    },
    servers: [
      {
        url: `http://localhost:${process.env.PORT || 4000}`,
        description: 'Development server',
      },
    ],
    components: {
      schemas: {
        DeviceVitals: {
          type: 'object',
          required: ['device_id', 'timestamp', 'thermal_value', 'battery_level', 'memory_usage'],
          properties: {
            device_id: {
              type: 'string',
              description: 'Unique identifier for the device',
              example: 'device-123',
            },
            timestamp: {
              type: 'string',
              format: 'date-time',
              description: 'ISO 8601 timestamp of the vitals reading',
              example: '2024-01-15T10:30:00.000Z',
            },
            thermal_value: {
              type: 'number',
              minimum: 0,
              maximum: 3,
              description: 'Thermal value of the device',
              example: 1.5,
            },
            battery_level: {
              type: 'number',
              minimum: 0,
              maximum: 100,
              description: 'Battery level percentage (0-100)',
              example: 85,
            },
            memory_usage: {
              type: 'number',
              minimum: 0,
              maximum: 100,
              description: 'Memory usage percentage (0-100)',
              example: 45,
            },
          },
        },
        DeviceVitalsResponse: {
          type: 'object',
          properties: {
            id: {
              type: 'string',
              description: 'Unique identifier for the vitals record',
            },
            device_id: {
              type: 'string',
            },
            timestamp: {
              type: 'string',
              format: 'date-time',
            },
            thermal_value: {
              type: 'number',
            },
            battery_level: {
              type: 'number',
            },
            memory_usage: {
              type: 'number',
            },
            createdAt: {
              type: 'string',
              format: 'date-time',
            },
            updatedAt: {
              type: 'string',
              format: 'date-time',
            },
          },
        },
        Pagination: {
          type: 'object',
          properties: {
            totalRecords: {
              type: 'number',
              description: 'Total number of records',
            },
            currentPage: {
              type: 'number',
              description: 'Current page number',
            },
            totalPages: {
              type: 'number',
              description: 'Total number of pages',
            },
            limit: {
              type: 'number',
              description: 'Number of records per page',
            },
          },
        },
        AnalyticsResponse: {
          type: 'object',
          properties: {
            device_id: {
              type: 'string',
              description: 'Device ID',
              example: 'device-123',
            },
            time_range: {
              type: 'object',
              properties: {
                from: {
                  type: 'string',
                  format: 'date-time',
                  description: 'Start timestamp of the time range',
                },
                to: {
                  type: 'string',
                  format: 'date-time',
                  description: 'End timestamp of the time range',
                },
              },
            },
            summary: {
              type: 'object',
              properties: {
                total_records: {
                  type: 'number',
                  description: 'Total number of records in the time range',
                },
                last_updated: {
                  type: 'string',
                  format: 'date-time',
                  description: 'Timestamp of the most recent record',
                },
              },
            },
            metrics: {
              type: 'object',
              properties: {
                thermal: {
                  type: 'object',
                  properties: {
                    average: {
                      type: 'number',
                      description: 'Average thermal value',
                    },
                    rolling_average: {
                      type: 'number',
                      description: 'Rolling average of last 3 values',
                    },
                    min: {
                      type: 'number',
                      description: 'Minimum thermal value',
                    },
                    max: {
                      type: 'number',
                      description: 'Maximum thermal value',
                    },
                  },
                },
                battery: {
                  type: 'object',
                  properties: {
                    average: {
                      type: 'number',
                      description: 'Average battery level',
                    },
                    rolling_average: {
                      type: 'number',
                      description: 'Rolling average of last 3 values',
                    },
                    min: {
                      type: 'number',
                      description: 'Minimum battery level',
                    },
                    max: {
                      type: 'number',
                      description: 'Maximum battery level',
                    },
                  },
                },
                memory: {
                  type: 'object',
                  properties: {
                    average: {
                      type: 'number',
                      description: 'Average memory usage',
                    },
                    rolling_average: {
                      type: 'number',
                      description: 'Rolling average of last 3 values',
                    },
                    min: {
                      type: 'number',
                      description: 'Minimum memory usage',
                    },
                    max: {
                      type: 'number',
                      description: 'Maximum memory usage',
                    },
                  },
                },
              },
            },
            series: {
              type: 'array',
              description: 'Downsampled time series data (max 8 points)',
              items: {
                type: 'object',
                properties: {
                  timestamp: {
                    type: 'string',
                    format: 'date-time',
                  },
                  thermal_value: {
                    type: 'number',
                  },
                  battery_level: {
                    type: 'number',
                  },
                  memory_usage: {
                    type: 'number',
                  },
                },
              },
            },
          },
        },
        Error: {
          type: 'object',
          properties: {
            message: {
              type: 'string',
              description: 'Error message',
            },
            errors: {
              type: 'array',
              items: {
                type: 'string',
              },
              description: 'Array of validation errors',
            },
          },
        },
      },
    },
  },
  apis: ['./src/routes/*.js', './src/controllers/*.js'], // Path to the API files
};

const swaggerSpec = swaggerJsdoc(options);

module.exports = swaggerSpec;
