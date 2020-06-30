module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define(
    "User",
    {
      first_name: DataTypes.STRING,
      last_name: DataTypes.STRING,
      code: DataTypes.STRING,
      email: {
        type: DataTypes.STRING,
        required: true,
        validate: {
          isEmail: true,
        },
      },
      password: {
        required: true,
        type: DataTypes.STRING,
      },
    },
    {
      defaultScope: {
        attributes: { exclude: ["createdAt", "updatedAt"] },
      },
    }
  );

  User.associate = (models) => {
    User.hasOne(models.Call, {
      foreignKey: "attendant_id",
    });
  };

  return User;
};
