const express = require("express");

const attendantLoginController = require("./app/controllers/auth/Attendant/LoginController");
const attendantController = require("./app/controllers/AttendantController");
const serviceController = require("./app/controllers/ServiceController");

const userController = require("./app/controllers/UserController");
const loginController = require("./app/controllers/auth/User/LoginController");
const forgotPassword = require("./app/controllers/auth/ForgotPassword");

const callController = require("./app/controllers/CallController");

const uploads = require("./app/middlewares/multer");
const auth = require("./app/middlewares/auth");
const checkType = require("./app/middlewares/attendant");

const routes = express.Router();

//Signup and Signin of mobile users
routes.post("/signup", userController.create);
routes.post("/signin", loginController.login);

routes.post("/attendant/signin", attendantLoginController.login);
routes.post("/attendant/signup", attendantController.create);

//Forgot password routes
routes.post("/forgotpassword", forgotPassword.sendEmail);
routes.post("/resetpassword", forgotPassword.resetPassword);

//User routes
// !Need to be protected
routes.get("/user", auth, checkType, userController.index);
routes
  .route("/user/:data")
  .get(auth, checkType, userController.show)
  .delete(auth, checkType, userController.delete);

//Attendant routes
// !Need to be protected
routes.route("/attendant").get(auth, attendantController.index);
routes
  .route("/attendant/:data")
  .get(auth, checkType, attendantController.show)
  .put(auth, checkType, attendantController.update)
  .delete(auth, checkType, attendantController.delete);

//Service route
// !Need to be protected
routes.post("/service/:type", auth, serviceController.updateVehiclesNumber);

//Call routes
routes.get("/call", auth, checkType, callController.index);
routes.post("/call", auth, uploads.any(), callController.create);
routes.get("/call/:field/:data", auth, callController.show);
routes.put("/call/:id", auth, checkType, callController.updateStatus);

module.exports = routes;
