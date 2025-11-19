import apiClient from "../../../../../Core/config/apiClient";

export function createLesson(data) {
  return apiClient.post("/lessons", data);
}

export function getLesson() {
  return apiClient.get("/lessons");
}

export function editLessonApi(data, id) {
  return apiClient.patch(`/lessons/${id}`, data);
}

export function deleteLessonApi(id) {
  return apiClient.delete(`/lessons/${id}`);
}
