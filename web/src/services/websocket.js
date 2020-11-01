import io from "socket.io-client";

const { id } = JSON.parse(localStorage.getItem("user"));
const socket = io("http://localhost:3334/admin", { query: { id } });

const getCallsCount = (calls) => {
  var callcount = 0;

  for (var aux of calls) {
    if (aux.status === null) callcount++;
  }

  return callcount;
};

function subscribeToCalls(cb) {
  socket.on("new_call", (call) => cb(null, call));
}

function emitCallsCount(calls) {
  socket.emit("set_calls_length", getCallsCount(calls));
}

export { subscribeToCalls, emitCallsCount };
