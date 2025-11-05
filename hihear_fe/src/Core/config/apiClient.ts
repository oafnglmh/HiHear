import axios from "axios";

const apiClient = axios.create({
  baseURL: "http://172.23.208.1:3000/api/v1/",
  headers: {
    "Content-Type": "application/json",
  },
  withCredentials: true,
});

export default apiClient;
