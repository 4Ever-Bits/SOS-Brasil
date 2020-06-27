const Account = require("../../../models/Account");
const User = require("../../../models/User");

const Validate = require("../../../utils/Validate");

const jwt = require("jsonwebtoken");

const { comparePsw } = require("../../../utils/ProcessPassword");

module.exports = {
  async login(req, res) {
    const { email, password } = req.body;

    try {
      Validate.isEmpty(email, "Email is empty");
      Validate.isEmpty(password, "Password is empty");

      const [account] = await Account.findWhere({ email: email });
      if (account.length < 1)
        return res.status(401).json({ error: "Auth failed" });

      let user = await User.findWhere({ "accounts.id": account.id });
      if (!user) return res.status(401).json({ error: "Auth failed" });
      [user] = user;

      if (await comparePsw(password, account.password)) {
        const payload = {
          id: account.id,
          email: account.email,
          type: "user",
        };

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
