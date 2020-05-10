const connection = require("../../database/connection");

const { cryptPsw } = require("../utils/ProcessPassword");

module.exports = {
  //Return all accounts
  async index() {
    const accounts = await connection("accounts").select("*");
    return accounts;
  },

  //Create a new account
  async create(email, pswd) {
    //Compare in database if email arealdy exist
    const data = await connection("accounts")
      .where({
        email: email,
      })
      .select("*");

    //Verify if email already exist
    if (data.length > 0) return "Email already exists";

    //Encrypt password
    let password = cryptPsw(pswd);

    //Create a new account
    const [id] = await connection("accounts").insert({
      email,
      password,
    });

    //Return the ID of current new account
    return id;
  },
  async delete(id) {
    await connection("accounts").where("id", id).delete();
    return true;
  },
};
