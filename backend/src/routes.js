const express = require("express");

const attendantLoginController = require("./app/controllers/auth/Attendant/LoginController");
const attendantController = require("./app/controllers/AttendantController");
const serviceController = require("./app/controllers/ServiceController");

const userController = require("./app/controllers/UserController");
const loginController = require("./app/controllers/auth/User/LoginController");
const forgotPassword = require("./app/controllers/auth/ForgotPassword");

const callController = require("./app/controllers/CallController");

const uploads = require("./app/config/multer");

const routes = express.Router();

//Signup and Signin of mobile users
routes.post("/signup", userController.create);
routes.post("/signin", loginController.login);

routes.post("/attendant/signin", attendantLoginController.login);

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

//Call routes
routes.post("/call", uploads.any(), callController.create);

module.exports = routes;
