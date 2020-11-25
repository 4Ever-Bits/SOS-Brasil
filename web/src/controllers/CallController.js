import api from "../config/axios";
import { logout } from "./SessionController";

export async function getCalls() {
  try {
    const { id } = JSON.parse(localStorage.getItem("user"));

    const { data } = await api.get(`/call/attendant_id/${id}`);

    return data;
  } catch (err) {
    console.error(err);
    logout();
  }
}

export async function updateCall(attendant_id, call_id, status) {
  try {
    const payload = {
      attendant_id,
      status,
    };

    await api.put(`/call/${call_id}`, payload);

    return true;
  } catch (err) {
    console.error(err);
    return false;
  }
}
