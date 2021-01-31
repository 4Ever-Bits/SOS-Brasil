"use strict";

const { DataTypes } = require("sequelize");

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return await queryInterface.createTable("Users", {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: DataTypes.INTEGER,
      },
      first_name: {
        allowNull: false,
        required: true,
        type: DataTypes.STRING,
      },
      last_name: {
        allowNull: false,
        required: true,
        type: DataTypes.STRING,
      },
      code: {
        allowNull: false,
        required: true,
        type: DataTypes.STRING,
      },
      email: {
        allowNull: false,
        required: true,
        unique: true,
        isEmail: true,
        type: DataTypes.STRING,
      },
      password: {
        allowNull: false,
        required: true,
        type: DataTypes.STRING,
      },
      createdAt: {
        allowNull: false,
        type: DataTypes.DATE,
      },
      updatedAt: {
        allowNull: false,
        type: DataTypes.DATE,
      },
    });
  },

  down: async (queryInterface, Sequelize) => {
    return await queryInterface.dropTable("Users");
  },
};
