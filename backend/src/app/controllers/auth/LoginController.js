const Account = require("../../models/Account");
const Validate = require("../../utils/Validate");

const jwt = require("jsonwebtoken");

const { comparePsw } = require("../../utils/ProcessPassword");

module.exports = {
  async login(req, res) {
    const { email, password } = req.body;

    try {
      Validate.isEmpty(email, "Email is empty");
      Validate.isEmpty(password, "Password is empty");

      const [user] = await Account.findWhere({ email: email });
      if (user.length < 1)
        return res.status(401).json({ error: "Auth failed" });

      if (await comparePsw(password, user.password)) {
        const payload = {
          id: user.id,
          email: user.email,
        };

        const token = jwt.sign(payload, process.env.AUTH_SECRET);

        return res.status(200).json({ message: "Auth successful", token });
      } else {
        return res.status(401).json({ error: "Auth failed" });
      }
    } catch (e) {
      console.log(e);
      return res.status(400).json(e);
    }
  },
};
