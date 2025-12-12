import { useState, useEffect, useCallback } from "react";
import { LessonApiService } from "../services/api/lessonApi";
import { LessonMapper } from "../utils/lessonMappers";
import toast from "react-hot-toast";

export const useLessonList = () => {
  const [lessons, setLessons] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const fetchLessons = useCallback(async () => {
    setLoading(true);
    setError(null);

    try {
      const data = await LessonApiService.getAll();
      const mappedLessons = data.map((lesson) =>
        LessonMapper.mapApiLessonToFormData(lesson)
      );

      setLessons(mappedLessons);
    } catch (err) {
      setError(err.message);
      toast.error("Không thể tải danh sách bài học");
      console.error("Fetch lessons error:", err);
    } finally {
      setLoading(false);
    }
  }, []);

  const deleteLesson = useCallback(async (id) => {
    try {
      await LessonApiService.delete(id);
      setLessons((prev) => prev.filter((l) => l.id !== id));
      toast.success("Xóa thành công");
    } catch (err) {
      toast.error("Xóa thất bại");
      console.error("Delete lesson error:", err);
      throw err;
    }
  }, []);

  useEffect(() => {
    fetchLessons();
  }, [fetchLessons]);

  return {
    lessons,
    loading,
    error,
    fetchLessons,
    deleteLesson,
  };
};
