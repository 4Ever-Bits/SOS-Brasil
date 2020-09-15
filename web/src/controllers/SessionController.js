import api from "../config/axios";

export async function login({ email, password }) {
  try {
    const { data } = await api.post("/signin", { email, password });
    return data.token;
  } catch (error) {
    throw Error(error.message);
  }
}
