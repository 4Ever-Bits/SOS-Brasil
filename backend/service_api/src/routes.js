const express = require("express");

const SessionController = require("./app/controllers/auth/SessionController");
const UserControlller = require("./app/controllers/UserControlller");
const CallController = require("./app/controllers/CallController");

const uploads = require("./app/middlewares/multer");
const authenticate = require("./app/middlewares/auth");
const attendAuth = require("./app/middlewares/attendantAuth");

const routes = express.Router();

routes.post("/signin", SessionController.create);
routes.post("/signup", UserControlller.create);

routes.get("/user", authenticate, attendAuth, UserControlller.index);
routes
  .route("/user/:data")
  .get(authenticate, attendAuth, UserControlller.show)
  .delete(authenticate, attendAuth, UserControlller.delete);

routes
  .route("/call")
  .get(authenticate, attendAuth, CallController.index)
  .post(authenticate, uploads.any(), CallController.create);

routes.put("/call/:id", authenticate, attendAuth, CallController.updateStatus);
routes.get("/call/:field/:data", authenticate, CallController.show);

module.exports = routes;
