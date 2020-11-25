"use strict";

module.exports = (sequelize, DataTypes) => {
  const Account = sequelize.define(
    "Account",
    {
      email: {
        type: DataTypes.STRING,
        require: true,
        validate: {
          isEmail: true,
        },
      },
      password: {
        require: true,
        type: DataTypes.STRING,
      },
      passwordResetToken: DataTypes.STRING,
      passwordResetExpires: DataTypes.DATE,
      active: DataTypes.BOOLEAN
    },
    {
      defaultScope: {
        attributes: {
          exclude: ["createdAt", "updatedAt"],
        },
      },
    }
  );

  Account.associate = (models) => {
    Account.hasOne(models.User, {
      foreignKey: "account_id",
      as: "user",
    });
  };

  return Account;
};
