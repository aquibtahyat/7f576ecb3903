const moment = require("moment");

/**
 * Calculate summary metrics: current, average, rolling_average, min, max
 * @param {Array} values - array of numbers
 */
const calculateMetrics = (values) => {
  if (!values.length) return null;

  const sum = values.reduce((a, b) => a + b, 0);
  const average = parseFloat((sum / values.length).toFixed(2));

  const rollingAverage = parseFloat(
    values.slice(-3).reduce((a, b) => a + b, 0) / Math.min(3, values.length)
  ).toFixed(2);

  return {
    average,
    rolling_average: parseFloat(rollingAverage),
    min: Math.min(...values),
    max: Math.max(...values),
  };
};

/**
 * Downsample series to max length (e.g., 8) by uniform interval
 * @param {Array} series - array of {timestamp, value}
 * @param {Number} maxLength
 */
const downsampleSeries = (series, maxLength = 8) => {
  if (series.length <= maxLength) return series;
  
  const step = Math.ceil(series.length / maxLength);
  const result = [];
  
  for (let i = 0; i < series.length; i += step) {
    result.push(series[i]);
    if (result.length >= maxLength) break;
  }
  
  if (result.length < maxLength && series.length > 0) {
    const lastPoint = series[series.length - 1];
    const lastResultPoint = result[result.length - 1];
    
    if (!lastResultPoint || lastResultPoint.timestamp !== lastPoint.timestamp) {
      result.push(lastPoint);
    }
  }
    
    return result;
  };

/**
 * Filter series data by date range
 * @param {Array} series
 * @param {String} dateRange - "24hrs", "3days", "7days", "14days", "30days"
 */
const filterSeriesByDateRange = (series, dateRange) => {
  const now = moment();
  let start;

  switch (dateRange) {
    case "24hrs":
      start = now.clone().subtract(24, "hours");
      break;
    case "3days":
      start = now.clone().subtract(3, "days");
      break;
    case "7days":
      start = now.clone().subtract(7, "days");
      break;
    case "14days":
      start = now.clone().subtract(14, "days");
      break;
    case "30days":
      start = now.clone().subtract(30, "days");
      break;
    default:
      start = now.clone().subtract(24, "hours");
  }

  return series.filter((item) => moment(item.timestamp).isSameOrAfter(start));
};

module.exports = {
  calculateMetrics,
  downsampleSeries,
  filterSeriesByDateRange,
};
