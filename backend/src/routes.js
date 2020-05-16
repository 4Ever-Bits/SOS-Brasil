const express = require("express");

const userController = require("./app/controllers/UserController");
const loginController = require("./app/controllers/auth/LoginController");

const routes = express.Router();

routes.post("/signup", userController.create);
routes.post("/signin", loginController.login);

routes.get("/user", userController.index);
routes
  .route("/user/:data")
  .get(userController.show)
  .delete(userController.delete);

module.exports = routes;
