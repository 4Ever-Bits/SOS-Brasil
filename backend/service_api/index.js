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

const server = require("http").createServer(app);

const io = require("socket.io")(server);
require("./src/services/websocket")(io);

const PORT = process.env.APP_PORT || 3334;

server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
