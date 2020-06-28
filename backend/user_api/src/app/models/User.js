module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define(
    "User",
    {
      first_name: DataTypes.STRING,
      last_name: DataTypes.STRING,
      phonenumber: DataTypes.STRING,
      cpf: DataTypes.STRING(14),
      AccountId: {
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
      foreignKey: "AccountId",
    });
  };

  return User;
};
