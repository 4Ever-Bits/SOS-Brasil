const { Op } = require("sequelize");

const { User, Account, Sequelize } = require("../models");
const Validate = require("../utils/Validate");

const { cryptPsw } = require("../utils/ProcessPassword");

module.exports = {
  //Show all users
  async index(req, res) {
    try {
      const users = await Account.findAll({
        attributes: ["id", "email"],
        include: {
          model: User,
          where: {
            AccountId: Sequelize.col("Account.id"),
          },
        },
      });
      return res.json(users);
    } catch (e) {
      console.log(e);
      return res.status(500).send();
    }
  },

  //   Create new user
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

      //Validate CPF
      const isValid = Validate.cpf(cpf);
      if (!isValid) return res.status(400).json({ error: "CPF is not valid" });

      //Separate name into first name and last name
      let nameArray = name.split(" ");
      let first_name = nameArray[0];
      let last_name = nameArray[nameArray.length - 1];

      // Encrypt password
      let cryptPassword = await cryptPsw(password);

      // Insert new account
      const account = await Account.create({
        email,
        password: cryptPassword,
      });

      //Insert new user
      const user = await User.create({
        first_name,
        last_name,
        phonenumber: phone,
        cpf,
        // longitude,
        // latitude,
        AccountId: account.id,
      });

      return res.status(200).json({ user });
    } catch (e) {
      if (typeof e === "string") return res.status(400).json({ error: e });
      else return res.status(400).json({ error: e.errors[0].message });
    }
  },

  //Show specified user by ID or email
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
        });
        if (dbResult) return res.status(200).json(dbResult);
      }

      // the parameter isn't an ID
      else {
        const dbResult = await Account.findOne({
          where: {
            email: {
              [Op.like]: `%${userData}`,
            },
          },
          attributes: ["id", "email"],
          include: [
            {
              model: User,
              where: {
                AccountId: Sequelize.col("Account.id"),
              },
            },
          ],
        });
        if (dbResult.length > 0) return res.status(200).json(dbResult);
      }

      return res.status(404).json({ error: "User not found" });
    } catch (e) {
      console.log(e);
      return res.status(500).send();
    }
  },

  //Delete specified user
  async delete(req, res) {
    try {
      const userData = req.params.data;

      // delete user and account field
      await Account.destroy({
        where: {
          id: userData,
        },
        include: [
          {
            model: User,
            where: {
              AccountId: Sequelize.col("Account.id"),
            },
          },
        ],
      });

      return res.status(200).send();
    } catch (e) {
      return res.status(404).json({ error: "User not found" });
    }
  },
};
