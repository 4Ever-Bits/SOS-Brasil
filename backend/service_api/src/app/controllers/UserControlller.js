const { Op } = require("sequelize");

const Validate = require("../utils/Validate");
const { cryptPsw } = require("../utils/ProcessPassword");
const { User } = require("../models");

module.exports = {
  async index(req, res) {
    const users = await User.findAll({
      attributes: { exclude: ["password"] },
    });
    res.status(200).json(users);
  },

  async create(req, res) {
    try {
      const { email, password, name, code } = req.body;

      Validate.isEmpty(name, "Name is empty");
      Validate.isEmpty(email, "Email is empty");
      Validate.isEmpty(password, "Password is empty");
      Validate.isEmpty(code, "Code is empty");

      const nameArray = name.split(" ");
      const first_name = nameArray[0];
      const last_name = nameArray[nameArray.length - 1];

      Validate.email(email, "Email is bad formated");

      let cryptPassword = await cryptPsw(password);

      const user = await User.create({
        first_name,
        last_name,
        email,
        password: cryptPassword,
        code,
      });

      return res.status(200).json({ id: user.id });
    } catch (e) {
      console.log(e);
      if (typeof e === "string") return res.status(400).json({ error: e });
      else return res.status(400).json({ error: e.errors[0].message });
    }
  },

  async show(req, res) {
    try {
      var checkByID = false;
      const userData = req.params.data;

      if (!isNaN(userData)) checkByID = true;

      // the parameter is an ID
      if (checkByID) {
        const dbResult = await User.findOne({
          where: {
            id: userData,
          },
          attributes: { exclude: ["password"] },
        });
        if (dbResult) return res.status(200).json(dbResult);
      }

      // the parameter isn't an ID
      else {
        const dbResult = await User.findAll({
          where: {
            email: {
              [Op.substring]: `${userData}`,
            },
          },
          attributes: { exclude: ["password"] },
        });
        if (dbResult.length > 1) return res.status(200).json(dbResult);
      }

      return res.status(404).json({ error: "User not found" });
    } catch (e) {
      console.log(e);
      return res.status(500).send();
    }
  },

  async delete(req, res) {
    try {
      const id = req.params.data;

      // delete user and account field
      const account = await User.destroy({
        where: {
          id: id,
        },
      });

      if (account) return res.status(200).send();
      else return res.status(404).json({ error: "User not found" });
    } catch (e) {
      return res.status(404).json({ error: "User not found" });
    }
  },
};
