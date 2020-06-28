const crypto = require("crypto");
const { Op } = require("sequelize");

const { Account } = require("../../models");

const mailer = require("../../../config/nodemailer");
const { cryptPsw } = require("../../utils/ProcessPassword");

module.exports = {
  async sendEmail(req, res) {
    try {
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

      const [account] = await Account.update(
        {
          passwordResetToken: token,
          passwordResetExpires: now,
        },
        {
          where: {
            email: email,
          },
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
    } catch (e) {
      console.log(e);

      return res.status(400).json({ error: "user not found" });
    }
  },

  async verifyCode(req, res) {
    const { token } = req.body;

    const account = await Account.findOne({
      where: {
        passwordResetToken: token,
      },
    });

    if (account) return res.status(200).send();
    else return res.status(400).send();
  },

  async reset(req, res) {
    try {
      const { email, token, password } = req.body;

      // Encrypt password
      let cryptPassword = await cryptPsw(password);

      const [account] = await Account.update(
        { password: cryptPassword },
        {
          where: {
            email: {
              [Op.eq]: email,
            },
            passwordResetToken: {
              [Op.eq]: token.toLowerCase(),
            },
            passwordResetExpires: {
              [Op.gt]: new Date(),
            },
          },
        }
      );

      console.log(account);

      //   const [account] = await Account.findWhere({ email: email });
      //   if (!account) return res.status(400).json({ error: "User not found" });

      //   if (token.toLowerCase() !== account.passwordResetToken.toLowerCase())
      //     return res.status(400).json({ error: "Auth failed" });
      //   if (new Date() > account.passwordResetExpires)
      //     return res.status(400).json({ error: "Auth failed" });

      //   const result = await Account.update(
      //     { email: email },
      //     {
      //       password: password,
      //     }
      //   );

      if (account) return res.send();
      else
        return res.status(400).json({ error: "Couldn't reset the password" });
    } catch (e) {
      console.log(e);
      return res.status(400).json({ error: "Couldn't reset the password" });
    }
  },
};
