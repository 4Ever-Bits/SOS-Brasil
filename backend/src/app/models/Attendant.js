const connection = require("../../database/connection");

const Account = require("./Account");

module.exports = Attendant = class Attendant extends Account {
  constructor({ first_name, last_name, code, email, password, service_id }) {
    super(email, password);
    this.first_name = first_name;
    this.last_name = last_name;
    this.code = code;
    this.email = email;
    this.password = password;
    this.service_id = service_id;
  }

  async create() {
    let account_id = await super.create(this.email, this.password);
    if (isNaN(account_id)) return { error: account_id };

    const [id] = await connection("attendants").insert({
      first_name: this.first_name,
      last_name: this.last_name,
      code: this.code,
      account_id: account_id,
      service_id: this.service_id,
    });

    return id;
  }

  static async delete(query) {
    const dbResult = await connection("attendants")
      .join("accounts", "accounts.id", "=", "attendants.account_id")
      .where(query)
      .select(["account_id"])
      .first();

    //Compare if user exist
    if (!dbResult) return false;
    const account_id = dbResult.account_id;

    await connection("attendants").where(query).delete();
    await super.delete({ id: account_id });

    return true;
  }

  static async update(query, data) {
    try {
      await connection("attendants")
        .join("accounts", "accounts.id", "=", "attendants.account_id")
        .join("services", "services.id", "=", "attendants.service_id")
        .where(query)
        .update(data);

      return true;
    } catch (e) {
      console.log(e);
      return false;
    }
  }

  static async findAll() {
    const attendants = await connection("attendants")
      .join("accounts", "accounts.id", "=", "attendants.account_id")
      .join("services", "services.id", "=", "attendants.service_id")
      .select([
        "attendants.id",
        "attendants.first_name",
        "attendants.last_name",
        "attendants.code",
        "accounts.email",
        "services.type",
        "attendants.created_at",
        "attendants.updated_at",
      ]);
    return attendants;
  }

  static async findWhere(query) {
    const [attendants] = await connection("attendants")
      .join("accounts", "accounts.id", "=", "attendants.account_id")
      .join("services", "services.id", "=", "attendants.service_id")
      .where(query)
      .select([
        "attendants.id",
        "attendants.first_name",
        "attendants.last_name",
        "attendants.code",
        "accounts.email",
        "services.type",
        "attendants.created_at",
        "attendants.updated_at",
      ]);
    return attendants;
  }

  static async findWhereLike(field, value) {
    const attendants = await connection("attendants")
      .join("accounts", "accounts.id", "=", "attendants.account_id")
      .join("services", "services.id", "=", "attendants.service_id")
      .where(`${field}`, "like", `%${value}%`)
      .select([
        "attendants.id",
        "attendants.first_name",
        "attendants.last_name",
        "attendants.code",
        "accounts.email",
        "services.type",
        "attendants.created_at",
        "attendants.updated_at",
      ]);
    return attendants;
  }
};
