import io from "socket.io-client";

const { id } = JSON.parse(localStorage.getItem("user"));
const socket = io("http://localhost:3334/admin", { query: { id } });

export default socket;
