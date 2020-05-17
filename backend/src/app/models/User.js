const connection = require("../../database/connection");
const Account = require("./Account");

module.exports = User = class User extends Account {
  constructor({
    email,
    password,
    first_name,
    last_name,
    phone,
    cpf,
    longitude,
    latitude,
  }) {
    super(email, password);

    this.email = email;
    this.password = password;
    this.first_name = first_name;
    this.last_name = last_name;
    this.phone = phone;
    this.cpf = cpf;
    this.longitude = longitude;
    this.latitude = latitude;
  }

  async create() {
    let first_name = this.first_name;
    let last_name = this.last_name;
    let phone = this.phone;
    let cpf = this.cpf;
    // let longitude = this.longitude;
    // let latitude = this.latitude;

    let account_id = await super.create(this.email, this.password);
    if (isNaN(account_id)) return { error: account_id };

    const [id] = await connection("users").insert({
      first_name,
      last_name,
      phonenumber: phone,
      cpf,
      account_id,
    });

    return id;
  }

  static async delete(query) {
    const dbResult = await connection("users")
      .join("accounts", "accounts.id", "=", "users.account_id")
      .where(query)
      .select(["users.account_id"])
      .first();

    //Compare if user exist
    if (!dbResult) return false;

    const account_id = dbResult.account_id;

    await connection("users").where(query).delete(); //Delete row in users
    await super.delete({ id: account_id });

    return true;
  }

  static async findAll() {
    const users = await connection("users")
      .join("accounts", "accounts.id", "=", "users.account_id")
      .select([
        "users.id",
        "users.first_name",
        "users.last_name",
        "accounts.email",
        "users.phonenumber",
        "users.cpf",
        "users.latitude",
        "users.longitude",
      ]);
    return users;
  }

  static async findWhere(query) {
    const dbResult = await connection("users")
      .join("accounts", "accounts.id", "=", "users.account_id")
      .where(query)
      .select([
        "users.id",
        "users.first_name",
        "users.last_name",
        "accounts.email",
        "users.phonenumber",
        "users.cpf",
        "users.latitude",
        "users.longitude",
      ]);

    if (dbResult.length > 0) return dbResult;
    else return false;
  }

  static async findWhereLike(field, value) {
    const dbResult = await connection("users")
      .join("accounts", "accounts.id", "=", "users.account_id")
      .where(`${field}`, "like", `%${value}%`)
      .select([
        "users.id",
        "users.first_name",
        "users.last_name",
        "accounts.email",
        "users.phonenumber",
        "users.cpf",
        "users.latitude",
        "users.longitude",
      ]);

    if (dbResult.length > 0) return dbResult;
    else return false;
  }
};
