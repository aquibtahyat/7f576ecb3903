const moment = require("moment");
const device_vitals = require("../models/deviceVitals.model");
const {
  calculateMetrics,
  downsampleSeries,
  filterSeriesByDateRange,
} = require("../utils/dashboard");

const createDeviceVitalsService = async (payload) => {
  try {
   const data = {
      device_id:payload.device_id,
      timestamp: payload.timestamp,
      thermal_value: payload.thermal_value,
      battery_level: payload.battery_level,
      memory_usage: payload.memory_usage
    }
    return await device_vitals.create(data);
  } catch (error) {
    throw new Error("Failed to add device vitals to the database");
  }
};


const fetchDeviceVitalsByDeviceId = async (device_id, pagination) => {
  try {
    const { skip, limit } = pagination;

    const [allData, total] = await Promise.all([
      device_vitals
        .find({ device_id })
        .sort({ timestamp: -1 })
        .skip(skip)
        .limit(limit)
        .lean(),

      device_vitals.countDocuments({ device_id })
    ]);

    const data = allData.map((d)=>({
      timestamp: d.timestamp,
      thermal_value: d.thermal_value,
      battery_level: d.battery_level,
      memory_usage: d.memory_usage
    }))

    return {
      data,
      total
    };
  } catch (error) {
    throw new Error("Failed to fetch device vitals");
  }
};


const getDeviceVitalsAnalytics = async (device_id, dateRange) => {
  try {
    const rawData = await device_vitals
      .find({ device_id })
      .sort({ timestamp: -1 })
      .lean();

    if (!rawData.length) return null;

    const filteredData = filterSeriesByDateRange(rawData, dateRange);

    if (!filteredData || filteredData.length === 0) {
      return null;
    }

    const dataSeries = filteredData.map((d) => ({
        timestamp: d.timestamp,
        memory_usage: d.memory_usage,
        battery_level: d.battery_level,
        thermal_value: d.thermal_value

      }));

    const thermalSeries = filteredData.map((d) => ({
      timestamp: d.timestamp,
      value: d.thermal_value,
    }));

    const batterySeries = filteredData.map((d) => ({
      timestamp: d.timestamp,
      value: d.battery_level,
    }));

    const memorySeries = filteredData.map((d) => ({
      timestamp: d.timestamp,
      value: d.memory_usage,
    }));

    const dataSeriesDownsample = downsampleSeries(dataSeries);

    const metrics = {
      thermal: { ...calculateMetrics(thermalSeries.map((d) => d.value)) },
      battery: { ...calculateMetrics(batterySeries.map((d) => d.value)) },
      memory: { ...calculateMetrics(memorySeries.map((d) => d.value))},
    };

    return {
      device_id,
      time_range: {
        from: filteredData[filteredData.length - 1].timestamp,
        to: filteredData[0].timestamp,
      },
      summary: {
        total_records: filteredData.length,
        last_updated: filteredData[0].timestamp,
      },
      metrics,
      series: dataSeriesDownsample
    };
  } catch (error) {
    throw new Error("Failed to generate analytics");
  }
};


module.exports = {
    createDeviceVitalsService,
    fetchDeviceVitalsByDeviceId,
    getDeviceVitalsAnalytics
};
