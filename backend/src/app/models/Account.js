const connection = require("../../database/connection");

const { cryptPsw } = require("../utils/ProcessPassword");

module.exports = Account = class Account {
  constructor(email, password) {
    this.email = email;
    this.password = password;
  }

  async create() {
    let email = this.email;
    let password = this.password;

    //Verify if email already exist
    const data = await connection("accounts")
      .where({
        email: email,
      })
      .select("*");
    if (data.length > 0) return "Email already exists";

    // Encrypt password
    let cryptPassword = cryptPsw(password);

    const [id] = await connection("accounts").insert({
      email,
      password: cryptPassword,
    });

    return id;
  }

  static async delete(query) {
    await connection("accounts").where(query).delete();
    return true;
  }

  static async findAll() {
    const accounts = await connection("accounts").select("*");
    return accounts;
  }

  static async findWhere(query) {
    const accounts = await connection("accounts").where(query).select("*");
    return accounts;
  }
};
