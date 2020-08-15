module.exports = (sequelize, DataTypes) => {
  const Call = sequelize.define(
    "Call",
    {
      title: DataTypes.STRING,
      description: DataTypes.TEXT,
      image_url: DataTypes.STRING,
      audio_url: DataTypes.STRING,
      latitude: DataTypes.FLOAT,
      longitude: DataTypes.FLOAT,
      ispersonal: DataTypes.BOOLEAN,
      user_id: DataTypes.INTEGER,
      attendant_id: DataTypes.INTEGER,
      status: DataTypes.BOOLEAN,
    },
    {
      defaultScope: {
        attributes: { exclude: ["createdAt", "updatedAt"] },
      },
    }
  );

  Call.associate = (models) => {
    Call.belongsTo(models.User, {
      foreignKey: "attendant_id",
      as: "attendant",
    });
  };

  return Call;
};
