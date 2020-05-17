const connection = require("../../database/connection");

module.exports = Service = class Service {
  static async updateAvailableVehicles(type, number) {
    try {
      const dbResult = await connection("services")
        .where({ type: type })
        .update({
          vehicles_available: number,
        });
      return dbResult;
    } catch (e) {
      console.log(e);
      return false;
    }
  }

  static async findAll() {
    const [services] = await connection("services").select("*");
    return services;
  }

  static async findWhere(query) {
    const [services] = await connection("services").where(query).select("*");
    return services;
  }
};
