"use strict";

const { DataTypes } = require("sequelize");

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return await queryInterface.createTable("Accounts", {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: DataTypes.INTEGER,
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
      passwordResetToken: {
        allowNull: true,
        type: DataTypes.STRING,
      },
      passwordResetExpires: {
        allowNull: true,
        type: DataTypes.DATE,
      },
      active: {
        allowNull: false,
        defaultValue: true,
        type: DataTypes.BOOLEAN,
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
    return await queryInterface.dropTable("Accounts");
  },
};
