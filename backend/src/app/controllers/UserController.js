const User = require("../models/User");
const Validate = require("../utils/Validate");

var currentUser = null;

module.exports = {
  //Show all users
  async index(req, res) {
    const users = await User.findAll();
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

      Validate.email(email, "Email is bad formated");

      //Separate name into first name and last name
      let nameArray = name.split(" ");
      let first_name = nameArray[0];
      let last_name = nameArray[nameArray.length - 1];

      //Validate CPF
      const isValid = Validate.cpf(cpf);
      if (!isValid) return res.status(400).json({ error: "CPF is not valid" });

      const user = {
        email,
        password,
        first_name,
        last_name,
        phone,
        cpf,
        // longitude,
        // latitude
      };

      currentUser = new User(user);
      const id = await currentUser.create();

      if (isNaN(id)) return res.status(400).json(id);

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
      const dbResult = await User.findWhere({ "users.id": userData });
      if (dbResult) return res.status(200).json(dbResult);
    } else {
      const dbResult = await User.findWhereLike("email", userData);
      if (dbResult) return res.status(200).json(dbResult);
    }

    return res.status(404).json({ error: "User not found" });
  },

  //Delete specified user
  async delete(req, res) {
    const userData = req.params.data;

    const dbResult = await User.delete({ "users.id": userData });

    //Compare if user exist
    if (!dbResult) return res.status(404).json({ error: "User not found" });
    return res.status(200).json({});
  },
};
