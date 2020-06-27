"use strict";

const { DataTypes } = require("sequelize");

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return await queryInterface.createTable("users", {
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
      phonenumber: {
        allowNull: false,
        required: true,
        type: DataTypes.STRING,
      },
      cpf: {
        allowNull: true,
        required: true,
        type: DataTypes.STRING(14),
      },
      AccountId: {
        allowNull: false,
        references: { model: "accounts", key: "id" },
        onDelete: "CASCADE",
        type: DataTypes.INTEGER,
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
    return await queryInterface.dropTable("users");
  },
};
