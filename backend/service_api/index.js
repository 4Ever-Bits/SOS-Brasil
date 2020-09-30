const express = require("express");
const cors = require("cors");
const path = require("path");

const routes = require("./src/routes");

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use("/uploads", express.static(path.join(__dirname, "uploads")));
app.use(routes);

app.listen(3334, () => console.log("Server running on port 3334"));
