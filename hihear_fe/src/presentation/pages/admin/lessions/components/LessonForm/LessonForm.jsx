import { Save, X } from "lucide-react";
import { PrerequisiteModal } from "./PrerequisiteModal";
import { Button } from "../ui/Button";
import { CategoryContent } from "./CategoryContent";
import { LANGUAGES, LESSON_CATEGORIES, LESSON_LEVELS } from "../../constants/lessonConstants";
import { Select, Textarea } from "../ui/Select";
import { Input } from "../ui/Input";
import { Modal } from "../ui/Modal";
import { LessonMapper } from "../../utils/lessonMappers";
import { useLessonForm } from "../../hooks/useLessonForm";
import { useLessonSubmit } from "../../hooks/useLessonSubmit";
import { useEffect, useState } from "react";

export const LessonForm = ({ lesson, lessonOptions, onClose, onSave }) => {
  const { formData, updateField, setFormData } = useLessonForm(lesson);
  const { isSubmitting, submitMultiLanguage, updateLesson } = useLessonSubmit();
  const [showPrerequisiteModal, setShowPrerequisiteModal] = useState(false);
  const [currentLangIndex, setCurrentLangIndex] = useState(0);
  const [prerequisiteLessons, setPrerequisiteLessons] = useState({
    Vietnam: null,
    Korea: null,
    UK: null,
  });

  useEffect(() => {
    if (lesson) {
      setFormData(LessonMapper.mapApiLessonToFormData(lesson));
    }
  }, [lesson, setFormData]);

  const handlePrerequisiteSelect = (selectedLesson) => {
    const currentLang = LANGUAGES[currentLangIndex];
    setPrerequisiteLessons((prev) => ({
      ...prev,
      [currentLang.code]: selectedLesson,
    }));

    if (currentLangIndex < LANGUAGES.length - 1) {
      setCurrentLangIndex(currentLangIndex + 1);
    } else {
      setShowPrerequisiteModal(false);
      proceedWithCreation();
    }
  };

  const proceedWithCreation = async () => {
    try {
      await submitMultiLanguage(formData, prerequisiteLessons);
      onSave();
    } catch (error) {
      console.error("Submission error:", error);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (lesson) {
      try {
        await updateLesson(formData);
        onSave();
      } catch (error) {
        console.error("Update error:", error);
      }
    } else {
      setCurrentLangIndex(0);
      setShowPrerequisiteModal(true);
    }
  };

  const categoryTitle = {
    [LESSON_CATEGORIES.VOCABULARY]: "Nội dung từ vựng",
    [LESSON_CATEGORIES.GRAMMAR]: "Nội dung ngữ pháp",
    [LESSON_CATEGORIES.PRONUNCIATION]: "Nội dung phát âm",
    [LESSON_CATEGORIES.LISTENING]: "Nội dung nghe hiểu",
    [LESSON_CATEGORIES.VIDEO]: "Nội dung video",
  }[formData.category];

  return (
    <>
      <Modal
        isOpen={true}
        onClose={onClose}
        title={lesson ? "Cập nhật bài học" : "Thêm bài học mới"}
        maxWidth="4xl"
      >
        <form onSubmit={handleSubmit} className="p-6 space-y-6">
          <div className="space-y-4">
            <Input
              label="Tên bài học"
              placeholder="Nhập tên bài học..."
              value={formData.title}
              onChange={(e) => updateField("title", e.target.value)}
              required
            />

            <Textarea
              label="Mô tả"
              placeholder="Nhập mô tả bài học..."
              value={formData.description}
              onChange={(e) => updateField("description", e.target.value)}
              rows={3}
            />

            <div className="grid grid-cols-2 gap-4">
              <Select
                label="Loại bài học"
                value={formData.category}
                onChange={(e) => updateField("category", e.target.value)}
                required
              >
                <option value="">Chọn loại</option>
                {Object.values(LESSON_CATEGORIES).map((cat) => (
                  <option key={cat} value={cat}>
                    {cat}
                  </option>
                ))}
              </Select>

              <Select
                label="Độ khó"
                value={formData.level}
                onChange={(e) => updateField("level", e.target.value)}
                required
              >
                {LESSON_LEVELS.map((lvl) => (
                  <option key={lvl} value={lvl}>
                    {lvl}
                  </option>
                ))}
              </Select>
            </div>
          </div>

          {formData.category && (
            <div className="border-t pt-6">
              <h3 className="text-lg font-semibold text-gray-900 mb-4">
                {categoryTitle}
              </h3>
              <CategoryContent
                category={formData.category}
                formData={formData}
                updateField={updateField}
              />
            </div>
          )}

          <div className="flex items-center gap-3 justify-end pt-6 border-t">
            <Button variant="secondary" onClick={onClose}>
              Hủy
            </Button>
            <Button
              type="submit"
              icon={Save}
              disabled={isSubmitting}
              loading={isSubmitting}
            >
              {lesson ? "Cập nhật" : "Thêm bài học (3 ngôn ngữ)"}
            </Button>
          </div>
        </form>
      </Modal>

      <PrerequisiteModal
        isOpen={showPrerequisiteModal}
        languages={LANGUAGES}
        currentIndex={currentLangIndex}
        lessonOptions={lessonOptions}
        onSelect={handlePrerequisiteSelect}
        onClose={() => {
          setShowPrerequisiteModal(false);
          setCurrentLangIndex(0);
          setPrerequisiteLessons({ Vietnam: null, Korea: null, UK: null });
        }}
      />
    </>
  );
};