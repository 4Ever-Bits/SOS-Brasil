const jwt = require("jsonwebtoken");

const { User } = require("../../models");

const Validate = require("../../utils/Validate");
const { comparePsw } = require("../../utils/ProcessPassword");

module.exports = {
  async create(req, res) {
    try {
      const { email, password } = req.body;

      Validate.isEmpty(email, "Email is empty");
      Validate.isEmpty(password, "Password is empty");

      const db_user = await User.findOne({
        where: {
          email: email,
        },
      });

      if (!db_user) return res.status(401).json({ error: "Auth failed" });

      if (await comparePsw(password, db_user.password)) {
        const payload = {
          id: db_user.id,
          email: db_user.email,
        };

        const token = jwt.sign(payload, process.env.AUTH_SECRET, {
          expiresIn: "8h",
        });

        const user = {
          id: db_user.id,
          first_name: db_user.first_name,
          last_name: db_user.last_name,
          code: db_user.code,
          email: db_user.email,
        };

        return res
          .status(200)
          .json({ message: "Auth successful", user, token });
      } else {
        return res.status(401).json({ error: "Auth failed" });
      }
    } catch (e) {
      console.log(e);
      return res.status(500).send(e);
    }
  },
};
