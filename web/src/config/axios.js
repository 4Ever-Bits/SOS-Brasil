import axios from "axios";

const api = axios.create({
  baseURL: "http://54.94.116.208:3334/",
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
