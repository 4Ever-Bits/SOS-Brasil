import io from "socket.io-client";

const userRaw = localStorage.getItem("user");

const { id } = JSON.parse(userRaw ? userRaw : '{"id": 0}');
const socket = io("http://192.168.0.150:3334/admin", {
  query: { id: id ? id : 0 },
});

const getCallsCount = (calls) => {
  var callcount = 0;

  if (calls) {
    for (var aux of calls) {
      if (aux.status === null) callcount++;
    }
  } else return 0;

  return callcount;
};

function subscribeToCalls(cb) {
  socket.on("new_call", (call) => cb(null, call));
}

function emitCallsCount(calls) {
  socket.emit("set_calls_length", getCallsCount(calls));
}

export { subscribeToCalls, emitCallsCount };
