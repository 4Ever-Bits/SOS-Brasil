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
    let cryptPassword = await cryptPsw(password);

    const [id] = await connection("accounts").insert({
      email,
      password: cryptPassword,
    });

    return id;
  }

  static async update(query, data) {
    try {
      let { password } = data;
      password = await cryptPsw(password);
      data.password = password;

      const result = await connection("accounts").where(query).update(data);
      if (Boolean(result)) return true;
      else return false;
    } catch (e) {
      console.log(e);
      return false;
    }
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
