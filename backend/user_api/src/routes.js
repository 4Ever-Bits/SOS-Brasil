const express = require("express");

const UserController = require("./app/controllers/UserController");
const SessionController = require("./app/controllers/auth/SessionController");
const PasswordController = require("./app/controllers/auth/PasswordController");

const routes = express.Router();

//Signup and Signin of mobile users
routes.post("/signin", SessionController.create);
routes.post("/signup", UserController.create);

//Forgot password routes
routes.post("/forgotpassword", PasswordController.sendEmail);
routes.post("/resetpassword", PasswordController.reset);

routes.route("/user").get(UserController.index);
routes
  .route("/user/:data")
  .post(UserController.show)
  .delete(UserController.delete);

module.exports = routes;
