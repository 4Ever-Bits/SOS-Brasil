"use strict";

const { DataTypes } = require("sequelize");

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return await queryInterface.createTable("Calls", {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: DataTypes.INTEGER,
      },
      title: {
        allowNull: false,
        required: true,
        type: DataTypes.STRING,
      },
      description: {
        allowNull: false,
        required: true,
        type: DataTypes.TEXT,
      },
      audio_url: {
        allowNull: true,
        required: false,
        type: DataTypes.STRING,
      },
      image_url: {
        allowNull: true,
        required: false,
        type: DataTypes.STRING,
      },
      latitude: {
        allowNull: true,
        required: false,
        type: DataTypes.FLOAT(10, 7),
      },
      longitude: {
        allowNull: true,
        required: false,
        type: DataTypes.FLOAT(10, 7),
      },
      ispersonal: {
        allowNull: false,
        required: true,
        type: DataTypes.BOOLEAN,
      },
      user_id: {
        allowNull: false,
        required: true,
        type: DataTypes.INTEGER,
      },
      attendant_id: {
        allowNull: true,
        references: { model: "Users", key: "id" },
        onDelete: "CASCADE",
        type: DataTypes.INTEGER,
      },
      status: {
        allowNull: true,
        required: false,
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
    return await queryInterface.dropTable("Calls");
  },
};
