import apiClient from "../../../../../../Core/config/apiClient";

export class LessonApiService {
  static async getAll() {
    const response = await apiClient.get("/lessons");
    return response.data;
  }

  static async create(data) {
    const response = await apiClient.post("/lessons", data);
    return response.data;
  }

  static async update(id, data) {
    const response = await apiClient.patch(`/lessons/${id}`, data);
    return response.data;
  }

  static async delete(id) {
    const response = await apiClient.delete(`/lessons/${id}`);
    return response.data;
  }
}