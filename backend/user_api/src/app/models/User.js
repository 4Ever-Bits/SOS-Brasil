module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define(
    "User",
    {
      first_name: DataTypes.STRING,
      last_name: DataTypes.STRING,
      phonenumber: DataTypes.STRING,
      cpf: DataTypes.STRING(14),
      account_id: {
        allowNull: false,
        required: true,
        type: DataTypes.INTEGER,
      },
    },
    {
      defaultScope: {
        attributes: { exclude: ["createdAt", "updatedAt"] },
      },
    }
  );

  User.associate = (models) => {
    User.belongsTo(models.Account, {
      foreignKey: "account_id",
      as: "user",
    });
  };

  return User;
};
