const express = require("express");

const attendantController = require("./app/controllers/AttendantController");
const serviceController = require("./app/controllers/ServiceController");

const userController = require("./app/controllers/UserController");
const loginController = require("./app/controllers/auth/LoginController");
const forgotPassword = require("./app/controllers/auth/ForgotPassword");

const routes = express.Router();

//Signup and Signin of mobile users
routes.post("/signup", userController.create);
routes.post("/signin", loginController.login);

//Forgot password routes
routes.post("/forgotpassword", forgotPassword.sendEmail);
routes.post("/resetpassword", forgotPassword.resetPassword);

//User routes
// !Need to be protected
routes.get("/user", userController.index);
routes
  .route("/user/:data")
  .get(userController.show)
  .delete(userController.delete);

//Attendant routes
// !Need to be protected
routes
  .route("/attendant")
  .get(attendantController.index)
  .post(attendantController.create);
routes
  .route("/attendant/:data")
  .get(attendantController.show)
  .put(attendantController.update)
  .delete(attendantController.delete);

//Service route
// !Need to be protected
routes.post("/service/:type", serviceController.updateVehiclesNumber);

module.exports = routes;
