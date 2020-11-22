import api from "../config/axios";

export async function login({ email, password }) {
  try {
    const { data } = await api.post("/signin", { email, password });

    delete data.user.code;

    localStorage.setItem("user", JSON.stringify(data.user));

    return data.token;
  } catch (error) {
    throw Error(error.message);
  }
}

export function logout() {
  localStorage.removeItem("token");
  localStorage.removeItem("user");
  window.location.reload();
}
