const express = require("express");

const userController = require("./app/controllers/UserController");

const routes = express.Router();

routes.get("/user", userController.index);
routes.post("/user", userController.create);

routes
  .route("/user/:data")
  .get(userController.show)
  .delete(userController.delete);

module.exports = routes;
