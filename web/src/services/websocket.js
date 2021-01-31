import io from "socket.io-client";

const userRaw = localStorage.getItem("user");

const { id } = JSON.parse(userRaw ? userRaw : '{"id": 0}');
const socket = io("http://54.94.116.208:3334/admin", {
  query: { id: id ? id : 0 },
});

function subscribeToCalls(cb) {
  socket.on("new_call", (call) => cb(null, call));
}

function emitCallsCount(length) {
  socket.emit("set_calls_length", length);
}

export { subscribeToCalls, emitCallsCount };
