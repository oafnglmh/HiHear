import { useState, useCallback } from "react";
import { DEFAULT_VOCABULARY_QUESTION } from "../constants/lessonConstants";

export const useLessonForm = (initialLesson = null) => {
  const [formData, setFormData] = useState({
    id: initialLesson?.id || "",
    title: initialLesson?.title || "",
    description: initialLesson?.description || "",
    category: initialLesson?.category || "",
    level: initialLesson?.level || "A1",
    preview: initialLesson?.preview || null,
    questions: initialLesson?.questions || [DEFAULT_VOCABULARY_QUESTION],
    grammarExamples: initialLesson?.grammarExamples || [],
    grammarRule: initialLesson?.grammarRule || "",
    pronunciationExamples: initialLesson?.pronunciationExamples || [],
    pronunciationOrder: initialLesson?.pronunciationOrder || 1,
    listenings: initialLesson?.listenings || [],
    videoData: initialLesson?.videoData || null,
  });

  const updateField = useCallback((field, value) => {
    setFormData((prev) => ({ ...prev, [field]: value }));
  }, []);

  const updateMultipleFields = useCallback((updates) => {
    setFormData((prev) => ({ ...prev, ...updates }));
  }, []);

  const resetForm = useCallback(() => {
    setFormData({
      id: "",
      title: "",
      description: "",
      category: "",
      level: "A1",
      preview: null,
      questions: [DEFAULT_VOCABULARY_QUESTION],
      grammarExamples: [],
      grammarRule: "",
      pronunciationExamples: [],
      pronunciationOrder: 1,
      listenings: [],
      videoData: null,
    });
  }, []);

  return {
    formData,
    updateField,
    updateMultipleFields,
    resetForm,
    setFormData,
  };
};