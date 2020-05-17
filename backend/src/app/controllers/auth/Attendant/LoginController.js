const Account = require("../../../models/Account");
const Attendant = require("../../../models/Attendant");

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

      const attendant = await Attendant.findWhere({
        "accounts.id": account.id,
      });

      if (!attendant) return res.status(401).json({ error: "Auth failed" });

      if (await comparePsw(password, account.password)) {
        const payload = {
          id: account.id,
          email: account.email,
          type: attendant.type,
        };

        const token = jwt.sign(payload, process.env.AUTH_SECRET, {
          expiresIn: "8h",
        });

        return res
          .status(200)
          .json({ message: "Auth successful", attendant, token });
      } else {
        return res.status(401).json({ error: "Auth failed" });
      }
    } catch (e) {
      console.log(e);
      return res.status(401).json({ error: "Auth failed" });
    }
  },
};
