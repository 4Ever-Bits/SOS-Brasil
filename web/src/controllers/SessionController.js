import api from "../config/axios";

export async function login({ email, password }) {
  try {
    const { data } = await api.post("/signin", { email, password });
    return data;
  } catch (error) {
    throw Error(error.message);
  }
}
