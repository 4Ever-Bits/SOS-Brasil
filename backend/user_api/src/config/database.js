module.exports = {
  username: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "",
  database: process.env.DB_NAME || "sosbrasil_user",
  host: process.env.DB_HOST || "127.0.0.1",
  dialect: process.env.DB_DIST || "mysql",
};
