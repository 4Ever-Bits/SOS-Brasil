const crypto = require("crypto");

const mailer = require("../../config/nodemailer");

const Account = require("../../models/Account");

module.exports = {
  async sendEmail(req, res) {
    const { email } = req.body;

    const token = crypto.randomBytes(3).toString("hex");
    const now = new Date();
    now.setHours(now.getHours() + 1);

    var message = {
      from: '"Test Server" <test@example.com>',
      to: email,
      subject: "Token",
      template: "auth/forgot_password",
      context: { token: token.toUpperCase() },
    };

    const account = await Account.update(
      { email: email },
      {
        passwordResetToken: token,
        passwordResetExpires: now,
      }
    );

    if (!account) return res.status(400).json({ error: "user not found" });
    else {
      mailer.sendMail(message, (err, info) => {
        if (err) {
          console.log(err);
          return res.status(404).send(err);
        }
        return res.json({
          message: "Email successfully sent.",
        });
      });
    }
  },

  async resetPassword(req, res) {
    const { email, token, password } = req.body;

    const [account] = await Account.findWhere({ email: email });
    if (!account) return res.status(400).json({ error: "User not found" });

    if (token.toLowerCase() !== account.passwordResetToken.toLowerCase())
      return res.status(400).json({ error: "Auth failed" });
    if (new Date() > account.passwordResetExpires)
      return res.status(400).json({ error: "Auth failed" });

    const result = await Account.update(
      { email: email },
      {
        password: password,
      }
    );

    if (result) return res.send();
    else return res.status(400).json({ error: "Couldn't reset the password" });
  },
};
