const express = require("express");
const cors = require("cors");
const routes = require("./src/routes");

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(routes);

const PORT = process.env.APP_PORT || 3333;

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
