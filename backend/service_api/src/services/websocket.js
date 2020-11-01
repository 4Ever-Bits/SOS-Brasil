const CallController = require("../app/controllers/CallController");
const jobScheduler = require("./jobScheduler");

exports = module.exports = function (io) {
  const attNmsp = io.of("/admin");

  attNmsp.on("connect", (client) => {
    console.log(
      `attendant ${client.id} has connected`,
      `attend id = ${client.handshake.query.id}`
    );

    client.on("set_calls_length", (length) => {
      client.handshake.query.callsCount = length;
      console.log(
        `attendant ${client.id} calls count = ${client.handshake.query.callsCount}`
      );
    });

    client.on("change_call_status", (status) => {});

    client.on("disconnect", () => {
      console.log(`attendant ${client.id} has disconnected`);
    });
  });

  const userNmsp = io.of("/user");

  userNmsp.on("connect", (client) => {
    console.log(
      `user ${client.id} has connected useID = ${client.handshake.headers["token"]}`
    );

    client.on("create_call", (data) => {
      var call = JSON.parse(data);
      var attendants = [];

      attNmsp.clients(async (error, clients) => {
        if (error) throw error;
        attendants = clients;
        await jobScheduler(attendants, call, io);
      });
    });

    client.on("disconnect", () => {
      console.log(`user ${client.id} has disconnected`);
    });
  });
};
