const connection = require("../../database/connection");

const accountController = require("./AccountController");

const Validate = require("../utils/Validate");

module.exports = {
  //Show all users
  async index(req, res) {
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
    return res.json(users);
  },

  //Create new user
  async create(req, res) {
    try {
      const { email, password } = req.body;
      const { name, phone, cpf } = req.body;

      Validate.isEmpty(name, "Name is empty");
      Validate.isEmpty(phone, "Phone number is empty");
      Validate.isEmpty(cpf, "CPF is empty");
      Validate.isEmpty(email, "Email is empty");
      Validate.isEmpty(password, "Password is empty");

      //Separate name into first name and last name
      let nameArray = name.split(" ");
      let first_name = nameArray[0];
      let last_name = nameArray[nameArray.length - 1];

      //Validate CPF
      const isValid = Validate.cpf(cpf);
      if (!isValid) return res.status(400).json({ error: "CPF is not valid" });

      //Return the ID of the created account
      const account_id = await accountController.create(email, password);

      //validate if email aready exist
      if (isNaN(account_id)) return res.status(400).json({ error: account_id });

      //Create the new user with current account ID
      const [id] = await connection("users").insert({
        first_name,
        last_name,
        phonenumber: phone,
        cpf,
        account_id,
      });

      return res.status(200).json({ id });
    } catch (e) {
      return res.status(400).json({ error: e });
    }
  },

  //Show specified user by ID or email
  async show(req, res) {
    var checkByID = false;
    const userData = req.params.data;

    if (!isNaN(userData)) checkByID = true;

    if (checkByID) {
      const dbResult = await connection("users")
        .join("accounts", "accounts.id", "=", "users.account_id")
        .where("users.id", userData)
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

      if (dbResult.length > 0) return res.status(200).json(dbResult);
    } else {
      const dbResult = await connection("users")
        .join("accounts", "accounts.id", "=", "users.account_id")
        .where("accounts.email", "like", `%${userData}%`)
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

      if (dbResult.length > 0) return res.status(200).json(dbResult);
    }

    return res.status(404).json({ error: "User not found" });
  },

  //Delete specified user
  async delete(req, res) {
    var checkByID = false;
    const userData = req.params.data;

    if (!isNaN(userData)) checkByID = true;

    if (checkByID) {
      //Get the account ID of current user
      const dbResult = await connection("users")
        .join("accounts", "accounts.id", "=", "users.account_id")
        .where("users.id", userData)
        .select(["users.account_id"])
        .first();

      //Compare if user exist
      if (!dbResult) return res.status(404).json({ error: "User not found" });

      const account_id = dbResult.account_id;

      await connection("users").where("id", userData).delete(); //Delete row in users
      await accountController.delete(account_id); //Delete row in accounts

      return res.status(200).json({});
    } else {
      //Get ID and account ID of current user
      const dbResult = await connection("users")
        .join("accounts", "accounts.id", "=", "users.account_id")
        .where("accounts.email", userData)
        .select(["users.id", "users.account_id"])
        .first();

      //Compare if user exist
      if (!dbResult) return res.status(404).json({ error: "User not found" });

      const id = dbResult.id;
      const account_id = dbResult.account_id;

      await connection("users").where("id", id).delete(); //Delete row in users
      await accountController.delete(account_id); //Delete row in accounts

      return res.status(200).json({});
    }
  },
};
