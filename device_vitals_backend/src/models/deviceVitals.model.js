const mongoose = require("mongoose");
const { v4: uuidv4 } = require("uuid");


const deviceVitalsSchema = new mongoose.Schema(
  {
    id: {
        type: String,
        default: () => uuidv4(),
        unique: true
      },

    device_id: {
      type: String,
      required: [true, "device_id is required"],
      trim: true
    },

    timestamp: {
      type: Date,
      required: [true, "timestamp is required"]
    },

    thermal_value: {
      type: Number,
      required: [true, "thermal_value is required"]
    },

    battery_level: {
      type: Number,
      required: [true, "battery_level is required"],
      min: 0,
      max: 100
    },

    memory_usage: {
      type: Number,
      required: [true, "memory_usage is required"],
      min: 0,
      max: 100
    }
  },
  {
    timestamps: true
  }
);

module.exports = mongoose.model("DeviceVitals", deviceVitalsSchema);
