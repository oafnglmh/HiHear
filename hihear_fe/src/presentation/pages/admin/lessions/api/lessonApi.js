import apiClient from "../../../../../Core/config/apiClient";

export function createLesson(data) {
  return apiClient.post("/lession", data);
}

export function getLesson() {
  return apiClient.get("/lession");
}

export function editLessonApi(data, id) {
  return apiClient.patch(`/lession/${id}`, data);
}

export function deleteLessonApi(id) {
  return apiClient.delete(`/lession/${id}`);
}
