const express = require("express");
const SessionController = require("./app/controllers/auth/SessionController");
const UserControlller = require("./app/controllers/UserControlller");
const CallController = require("./app/controllers/CallController");

const uploads = require("./app/middlewares/multer");

const routes = express.Router();

routes.post("/signin", SessionController.create);
routes.post("/signup", UserControlller.create);

routes.get("/user", UserControlller.index);
routes
  .route("/user/:data")
  .get(UserControlller.show)
  .delete(UserControlller.delete);

routes
  .route("/call")
  .get(CallController.index)
  .post(uploads.any(), CallController.create);

routes.route("/call/:id").put(CallController.updateStatus);
routes.get("/call/:field/:data", CallController.show);

module.exports = routes;
