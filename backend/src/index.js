const express = require("express");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.status(200).json({ status: "Server is running" });
});

app.listen(3333, () => console.log("Server running on port 3333"));
