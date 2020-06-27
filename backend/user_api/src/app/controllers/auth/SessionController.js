const jwt = require("jsonwebtoken");
const Sequelize = require("sequelize");

const { Account, User } = require("../../models");

const { comparePsw } = require("../../utils/ProcessPassword");
const Validate = require("../../utils/Validate");

module.exports = {
  async create(req, res) {
    const { email, password } = req.body;

    try {
      Validate.isEmpty(email, "Email is empty");
      Validate.isEmpty(password, "Password is empty");

      const account = await Account.findOne({
        where: {
          email: email,
        },
        include: {
          model: User,
          where: {
            AccountId: Sequelize.col("Account.id"),
          },
        },
      });

      if (!account) return res.status(401).json({ error: "Auth failed" });

      if (await comparePsw(password, account.password)) {
        const payload = {
          id: account.id,
          email: account.email,
          type: "user",
        };

        const user = account["Users"][0];

        const token = jwt.sign(payload, process.env.AUTH_SECRET);

        return res
          .status(200)
          .json({ message: "Auth successful", user, token });
      } else {
        return res.status(401).json({ error: "Auth failed" });
      }
    } catch (e) {
      console.log(e);
      return res.status(401).json({ error: "Auth failed" });
    }
  },
};
