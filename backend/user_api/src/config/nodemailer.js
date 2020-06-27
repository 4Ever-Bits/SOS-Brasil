const nodemailer = require("nodemailer");
const hbs = require("nodemailer-express-handlebars");

var transporter = nodemailer.createTransport({
  host: process.env.MAIL_HOST,
  port: parseInt(process.env.MAIL_PORT),
  auth: {
    user: process.env.MAIL_AUTH_USER,
    pass: process.env.MAIL_AUTH_PASS,
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
