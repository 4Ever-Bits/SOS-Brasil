const fs = require("fs");
const path = require("path");
const Sequelize = require("sequelize");
const config = require("../../config/database.js");

const db = {};
const sequelize = new Sequelize(config);

/* eslint-disable-next-line security/detect-non-literal-fs-filename -- Safe as no value holds user input */
fs.readdirSync(__dirname)
  .filter(
    (file) =>
      file.indexOf(".") !== 0 &&
      file !== path.basename(__filename) &&
      file.slice(-3) === ".js"
  )
  .forEach((file) => {
    /* eslint-disable-next-line security/detect-non-literal-require -- Safe as no value holds user input */
    const model = require(path.join(__dirname, file))(
      sequelize,
      Sequelize.DataTypes
    );
    db[model.name] = model;
  });

Object.keys(db).forEach((modelName) => {
  /* eslint-disable-next-line security/detect-object-injection -- Safe as no value holds user input */
  if (db[modelName].associate) {
    /* eslint-disable-next-line security/detect-object-injection -- Safe as no value holds user input */
    db[modelName].associate(db);
  }
});

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;
