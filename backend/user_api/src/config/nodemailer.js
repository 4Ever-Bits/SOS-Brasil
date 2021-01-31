const nodemailer = require("nodemailer");
const hbs = require("nodemailer-express-handlebars");

var transporter = nodemailer.createTransport({
  host: process.env.MAIL_HOST || "smtp.mailtrap.io",
  port: parseInt(process.env.MAIL_PORT) || 2525,
  auth: {
    user: process.env.MAIL_AUTH_USER || "f01a8fa433023c",
    pass: process.env.MAIL_AUTH_PASS || "2bf9f21e8b36ae",
  },
});

transporter.use(
  "compile",
  hbs({
    viewEngine: {
      extName: ".hbs",
      partialsDir: "./src/resources/mail/",
      layoutsDir: "./src/resources/mail/",
      defaultLayout: null,
    },
    viewPath: "./src/resources/mail/",
    extName: ".hbs",
  })
);

transporter.verify(function (error, success) {
  if (error) {
    console.log(error);
  }
});

module.exports = transporter;
