module.exports = {
  username: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "ph261202",
  database: process.env.DB_NAME || "sosbrasil_service",
  host: process.env.DB_HOST || "54.94.116.208",
  dialect: process.env.BD_DIST || "mysql",
};
