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
    Account.hasMany(models.User);
  };

  return Account;
};
