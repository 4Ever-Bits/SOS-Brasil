const nodemailer = require("nodemailer");
const hbs = require("nodemailer-express-handlebars");

var transporter = nodemailer.createTransport({
  host: "smtp.mailtrap.io",
  port: 2525,
  auth: {
    user: "f01a8fa433023c",
    pass: "2bf9f21e8b36ae",
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
