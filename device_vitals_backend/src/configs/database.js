const mongoose = require('mongoose')
const db_url = process.env.DATABASE_URL;

const connectDB = async () => {
    try {
      const conn = await mongoose.connect(db_url);
      console.log(`MongoDB Connected: ${conn.connection.host}`);
    } catch (error) {
      console.error(error.message);
      process.exit(1);
    }
  };
  

  module.exports = connectDB;