import { useState, useCallback } from "react";
import { LessonApiService } from "../services/api/lessonApi";
import { LessonService } from "../services/lessonService";
import { TranslationService } from "../utils/translationUtils";
import { LANGUAGES } from "../constants/lessonConstants";
import toast from "react-hot-toast";

export const useLessonSubmit = () => {
  const [isSubmitting, setIsSubmitting] = useState(false);

  const submitMultiLanguage = useCallback(
    async (formData, prerequisiteLessons) => {
      setIsSubmitting(true);
      const toastId = toast.loading("Đang tạo bài học đa ngôn ngữ...");

      try {
        await Promise.all(
          LANGUAGES.map(async (lang) => {
            const translatedTitle =
              lang.langCode === "vi"
                ? formData.title
                : await TranslationService.translateText(
                    formData.title,
                    lang.langCode
                  );

            let translatedData = { ...formData, title: translatedTitle };

            if (lang.langCode !== "vi") {
              if (formData.category === "Từ vựng") {
                const translatedQuestions =
                  await TranslationService.translateVocabulary(
                    formData.questions,
                    lang.langCode
                  );
                translatedData.questions = translatedQuestions;
              } else if (formData.category === "Ngữ pháp") {
                const translatedExamples =
                  await TranslationService.translateGrammar(
                    formData.grammarExamples,
                    lang.langCode
                  );
                translatedData.grammarExamples = translatedExamples;
              }
            }

            const prerequisiteId = prerequisiteLessons[lang.code];
            const payload = LessonService.createLessonPayload(
              formData,
              lang.code,
              translatedData,
              prerequisiteId
            );

            return LessonApiService.create(payload);
          })
        );

        toast.success("Tạo thành công 3 phiên bản ngôn ngữ!", { id: toastId });
        return { success: true };
      } catch (err) {
        toast.error("Có lỗi xảy ra khi tạo bài học!", { id: toastId });
        console.error(err);
        throw err;
      } finally {
        setIsSubmitting(false);
      }
    },
    []
  );

  const updateLesson = useCallback(async (formData) => {
    setIsSubmitting(true);

    try {
      const payload = LessonService.createLessonPayload(
        formData,
        "Vietnam",
        null,
        null
      );

      const result = await LessonApiService.update(formData.id, payload);
      toast.success("Cập nhật thành công!");
      return { success: true, data: result };
    } catch (err) {
      toast.error("Cập nhật thất bại!");
      console.error(err);
      throw err;
    } finally {
      setIsSubmitting(false);
    }
  }, []);

  return {
    isSubmitting,
    submitMultiLanguage,
    updateLesson,
  };
};