const Joi = require("joi");

const addDeviceVitalsValidator = Joi.object({
  device_id: Joi.string()
    .required()
    .messages({
      "string.base": "device_id must be string",
      "string.required": "device_id is required",
    }),
  timestamp: Joi.date()
    .iso()
    .max('now')
    .required()
    .messages({
      "date.base": "timestamp must be a valid date",
      "date.format": "timestamp must be in ISO format",
      "date.max": "timestamp cannot be in the future",
      "any.required": "timestamp is required"
    }),

  thermal_value: Joi.number()
    .strict()
    .min(0)
    .max(3)
    .required()
    .messages({
      "number.base": "thermal_value must be a number",
      "any.required": "thermal_value is required"
    }),

  battery_level: Joi.number()
    .strict()
    .min(0)
    .max(100)
    .required()
    .messages({
      "number.base": "battery_level must be a number",
      "number.min": "battery_level cannot be less than 0",
      "number.max": "battery_level cannot exceed 100",
      "any.required": "battery_level is required"
    }),

  memory_usage: Joi.number()
    .strict()
    .min(0)
    .max(100)
    .required()
    .messages({
      "number.base": "memory_usage must be a number",
      "number.min": "memory_usage cannot be negative",
      "any.required": "memory_usage is required"
    })
});

module.exports = {
  addDeviceVitalsValidator
};
