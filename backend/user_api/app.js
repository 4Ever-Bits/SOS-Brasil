const express = require("express");
const cors = require("cors");
const routes = require("./src/routes");

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(routes);

app.listen(3000, () => console.log("Server running on port 3000"));
