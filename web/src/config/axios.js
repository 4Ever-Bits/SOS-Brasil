import axios from "axios";

const api = axios.create({
  baseURL: "http://201.75.9.143:3002",
  headers: {
    "Access-Control-Allow-Origin": "*",
  },
});

api.interceptors.request.use(async (config) => {
  const token = localStorage.getItem("token");
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export default api;
