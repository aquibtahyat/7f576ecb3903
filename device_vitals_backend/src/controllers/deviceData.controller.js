const { addDeviceVitalsValidator } = require("../validations/deviceVitalsValidator");
const { createDeviceVitalsService,fetchDeviceVitalsByDeviceId,getDeviceVitalsAnalytics } = require("../service/deviceVitals.service");
const { getPagination } = require("../utils/pagination");

const addDeviceVitals = async (req, res) => {
  try {
    const { error, value } = addDeviceVitalsValidator.validate(req.body, {
      abortEarly: false
    });

    if (error) {
      return res.status(400).json({
        message: "Validation failed",
        errors: error.details.map(err => err.message)
      });
    }


    const deviceVitals = await createDeviceVitalsService(value);

    return res.status(201).json({
      message: "Device vitals added successfully",
    });

  } catch (error) {
    console.error("Error adding device vitals:", error);

    return res.status(500).json({
      message: "Internal server error"
    });
  }
};


const getDeviceVitalsController = async (req, res) => {
  try {
    const {id}= req.params
    const { page, limit } = req.query;

    if (!id) {
      return res.status(400).json({
        message: "device_id param is required"
      });
    }

    const pagination = getPagination(page, limit);

    const result = await fetchDeviceVitalsByDeviceId(id, pagination);

    if (!result.data || result.data.length === 0) {
      return res.status(404).json({
        message: "No device vitals found for the given device_id"
      });
    }

    return res.status(200).json({
      message: "Device vitals fetched successfully",
      pagination: {
        totalRecords: result.total,
        currentPage: pagination.page,
        totalPages: Math.ceil(result.total / pagination.limit),
        limit: pagination.limit
      },
      data: result.data
    });

  } catch (error) {
    console.error("Error fetching device vitals:", error.message);

    return res.status(500).json({
      message: error.message || "Internal server error"
    });
  }
};

const getAnalyticsController = async (req, res) => {
  try {
    const {id}= req.params
    const { date_range } = req.query;
  
    if (!id) {
      return res.status(400).json({ message: "device_id is required" });
    }

      if (!date_range) {
      return res.status(400).json({ message: "date_range is required" });
    }

    const analytics = await getDeviceVitalsAnalytics(id, date_range);

    if (!analytics) {
      return res.status(404).json({
        message: "No data found for the given device and date range",
      });
    }

    return res.status(200).json(analytics);
  } catch (error) {
    console.error("Error generating analytics:", error.message);
    return res.status(500).json({ message: error.message });
  }
};

module.exports = {
  addDeviceVitals,
  getDeviceVitalsController,
  getAnalyticsController
};
