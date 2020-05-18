const connection = require("../../database/connection");

module.exports = Call = class Call {
  static async create(data) {
    try {
      const [id] = await connection("calls").insert(data);
      return id;
    } catch (e) {
      console.log(e);
      throw e;
    }
  }

  static async findAll() {}

  static async findWhere() {}

  static async findWhereLike() {}
};
