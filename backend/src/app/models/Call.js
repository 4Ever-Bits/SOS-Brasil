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

  static async findAll(page, limit, order, asc) {
    let aux = null;
    if (asc === "true") aux = "asc";
    else aux = "desc";

    const [count] = await connection("calls").count();

    const calls = await connection("calls")
      .join("services", "services.id", "=", "calls.service_id")
      .join("users", "users.id", "=", "calls.user_id")
      .limit(limit)
      .offset((page - 1) * limit)
      .orderBy("calls." + order, aux)
      .select([
        "calls.*",
        "users.first_name",
        "users.last_name",
        "users.phonenumber",
        "users.cpf",
        "services.type",
        "services.vehicles_available",
      ]);

    return { calls, count };
  }

  static async findWhere(query) {
    const call = await connection("calls")
      .join("services", "services.id", "=", "calls.service_id")
      .join("users", "users.id", "=", "calls.user_id")
      .where(query)
      .select([
        "calls.*",
        "users.first_name",
        "users.last_name",
        "users.phonenumber",
        "users.cpf",
        "services.type",
        "services.vehicles_available",
      ])
      .first();

    return call;
  }

  static async findWhereLike(field, value, req) {
    try {
      const { page = 1, limit = 10, order = "id", asc = "true" } = req;

      let aux = null;
      if (asc === "true") aux = "asc";
      else aux = "desc";

      const [count] = await connection("calls")
        .where(field, "like", value)
        .count();

      const calls = await connection("calls")
        .join("services", "services.id", "=", "calls.service_id")
        .join("users", "users.id", "=", "calls.user_id")
        .where(field, "like", value)
        .limit(limit)
        .offset((page - 1) * limit)
        .orderBy("calls." + order, aux)
        .select([
          "calls.*",
          "users.first_name",
          "users.last_name",
          "users.phonenumber",
          "users.cpf",
          "services.type",
          "services.vehicles_available",
        ]);

      return { calls, count };
    } catch (e) {
      console.log(e);
      throw e;
    }
  }

  static async updateStatus(id, data) {
    const { status, attendant_id } = data;

    const dbResult = await connection("calls").where("id", "=", id).update({
      attendant_id: attendant_id,
      status: status,
    });

    if (dbResult) return true;
    else return false;
  }
};
