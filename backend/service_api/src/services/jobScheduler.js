const { Call, User } = require("../app/models");
const axios = require("axios");

const URL = process.env.USER_API_URL || "http://localhost:3001";

module.exports = async function (attendantArray, call, io) {
  attendantArray.sort(function (att1, att2) {
    console.log(att1.callsCount, att2.callsCount);
    if (att1.callsCount > att2.callsCount) return 1;
    if (att1.callsCount < att2.callsCount) return -1;
    return 0;
  });

  console.log(attendantArray, call);
  call.status = null;

  const attId =
    io.sockets.connected[attendantArray[0].split("#")[1]].handshake.query.id;

  console.log(
    `choosed attendant: ${attendantArray[0].split("#")[1]}`,
    io.sockets.connected[attendantArray[0].split("#")[1]].handshake.query
      .callsCount
  );

  if (await assignAtt(attId, call.id)) {
    const newCall = await getAssignedCall(call.id);
    if (newCall) {
      io.of("/admin").to(attendantArray[0]).emit("new_call", newCall);
    }
  }
};

async function assignAtt(attendId, callId) {
  try {
    const [call] = await Call.update(
      {
        attendant_id: attendId,
        status: null,
      },
      {
        where: {
          id: callId,
        },
      }
    );

    if (call) return true;
    else return false;
  } catch (e) {
    console.error(e);
    return false;
  }
}

async function getAssignedCall(callId) {
  try {
    const call = await Call.findOne({
      where: { id: callId },
      attributes: {
        include: ["createdAt"],
        exclude: ["attendant_id"],
      },
      include: {
        model: User,
        as: "attendant",
        attributes: {
          exclude: ["password", "createdAt", "updatedAt", "code"],
        },
      },
    });

    if (call) {
      const response = await axios.get(URL + `/user/${call.user_id}`);
      const user = response.data;
      delete call.dataValues["user_id"];
      delete user["AccountId"];

      return { ...call.dataValues, user };
    } else return false;
  } catch (e) {
    console.error(e);
    return false;
  }
}
