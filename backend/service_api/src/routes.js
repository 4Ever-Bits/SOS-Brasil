const express = require("express");
const SessionController = require("./app/controllers/auth/SessionController");
const UserControlller = require("./app/controllers/UserControlller");

const routes = express.Router();

routes.post("/signin", SessionController.create);
routes.post("/signup", UserControlller.create);

routes.get("/user", UserControlller.index);
routes
  .route("/user/:data")
  .get(UserControlller.show)
  .delete(UserControlller.delete);

module.exports = routes;
