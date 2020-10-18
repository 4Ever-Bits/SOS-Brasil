exports = module.exports = function (io) {
  const attNmsp = io.of("/admin");

  attNmsp.on("connect", (client) => {
    console.log(`attendant ${client.id} has connected`);

    client.on("change_call_status", (status) => {});

    client.on("disconnect", () => {
      console.log(`user ${client.id} has disconnected`);
    });
  });

  const userNmsp = io.of("/user");

  userNmsp.on("connect", (client) => {
    console.log(`user ${client.id} has connected`);

    client.on("create_call", (call) => {
      console.log(call);
    });

    client.on("disconnect", () => {
      console.log(`user ${client.id} has disconnected`);
    });
  });
};
