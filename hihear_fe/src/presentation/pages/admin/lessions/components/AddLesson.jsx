import React, { useState, useEffect } from "react";
import { X, Save, Plus } from "lucide-react";
import { useLessonForm } from "../hooks/useLessonForm";
import QuestionForm from "./QuestionForm";
import GrammarForm from "./GrammarForm";
import PronunciationForm from "./PronunciationForm";
import { saveLesson, editLesson } from "../services/lessonService";
import toast from "react-hot-toast";
import "../css/Lessons.css";

const translateText = async (text, targetLang) => {
  try {
    const langCode = targetLang === "Tiếng Hàn" ? "ko" : "en";
    const encodedText = encodeURIComponent(text);
    const url = `https://api.mymemory.translated.net/get?q=${encodedText}&langpair=vi|${langCode}`;

    const response = await fetch(url);
    const data = await response.json();

    if (data.responseStatus === 200) return data.responseData.translatedText;
    return text;
  } catch (error) {
    console.error("Translation error:", error);
    return text;
  }
};

export default function AddLesson({
  onClose,
  onSave,
  lessonOptions = [],
  editingLesson = null,
}) {
  const {
    id,
    setId,
    title,
    setTitle,
    category,
    setCategory,
    level,
    setLevel,
    preview,
    handleImageChange,
    questions,
    setQuestions,
    handleAddQuestion,
    handleDeleteQuestion,
    handleChangeQuestion,

    // Grammar
    grammarExamples,
    setGrammarExamples,
    grammarRule,
    setGrammarRule,

    // Pronunciation
    pronunciationExamples,
    setPronunciationExamples,
    pronunciationOrder,
    setPronunciationOrder,
  } = useLessonForm();

  const [type, setType] = useState("Từ vựng");
  const [description, setDescription] = useState("");
  const [prerequisiteLesson, setPrerequisiteLesson] = useState(null);
  const [isTranslating, setIsTranslating] = useState(false);

  // =============== LOAD EDITING LESSON ===================
  useEffect(() => {
    if (!editingLesson) return;

    setId(editingLesson.id || "");
    setTitle(editingLesson.title || "");
    setCategory(editingLesson.category || "");
    setLevel(editingLesson.level || "Dễ");
    setDescription(editingLesson.description || "");
    setPrerequisiteLesson(editingLesson.prerequisiteLesson || null);
    setType(editingLesson.type || "Từ vựng");

    setQuestions(editingLesson.questions || []);

    setGrammarRule(editingLesson.grammarRule || "");
    setGrammarExamples(editingLesson.grammarExamples || []);

    setPronunciationExamples(editingLesson.pronunciationExamples || []);
    setPronunciationOrder(editingLesson.pronunciationOrder || 1);
  }, [editingLesson]);

  // ==========================================================
  // BUILD EXERCISES
  // ==========================================================
  const buildExercises = (lang = "Vietnam", translatedData = null) => {
    if (category === "Từ vựng") {
      const questionsToUse = translatedData || questions;
      return [
        {
          type: "mcq",
          points: 5,
          national: lang,
          vocabularies: questionsToUse.map((q) => ({
            question: q.text,
            choices: [q.optionA, q.optionB],
            correctAnswer: q.correct === "A" ? q.optionA : q.optionB,
          })),
        },
      ];
    }

    if (category === "Ngữ pháp") {
      const examplesToUse = translatedData || grammarExamples;

      return [
        {
          type: "mcq",
          points: 0,
          national: lang,
          vocabularies: [],
          grammars: examplesToUse.map((ex) => ({
            grammarRule: description, // mô tả chung
            example: ex.example, // 1 ví dụ
            meaning: ex.meaning, // ý nghĩa ví dụ
          })),
        },
      ];
    }

    if (category === "Phát Âm") {
      return [
        {
          type: "listening",
          points: 0,
          national: lang,
          vocabularies: [],
          grammars: [],
          listenings: pronunciationExamples.map((ex) => ({
            example: ex.text,
            meaning: "",
          })),
        },
      ];
    }

    return [];
  };

  // ============= TRANSLATION HELPERS =======================

  const translateVocabularyQuestions = async (targetLang) => {
    return Promise.all(
      questions.map(async (q) => {
        const translatedOptionA = await translateText(q.optionA, targetLang);
        const translatedOptionB = await translateText(q.optionB, targetLang);

        return {
          ...q,
          optionA: translatedOptionA,
          optionB: translatedOptionB,
        };
      })
    );
  };

  const translateGrammarExamples = async (targetLang) => {
    return Promise.all(
      grammarExamples.map(async (ex) => {
        const translatedMeaning = await translateText(ex.meaning, targetLang);
        return {
          ...ex,
          meaning: translatedMeaning,
        };
      })
    );
  };

  // ==========================================================
  // SUBMIT
  // ==========================================================
  const handleSubmit = async (e) => {
    e.preventDefault();

    // UPDATE LESSON
    if (editingLesson) {
      const payload = {
        title,
        description,
        category,
        level,
        prerequisiteLesson,
        mediaId: preview || null,
        exercises: buildExercises("Vietnam"),
      };

      try {
        const result = await editLesson(payload, id);
        toast.success("Cập nhật thành công!");
        onSave(result.data);
        onClose();
      } catch (err) {
        toast.error("Cập nhật thất bại!");
        console.error(err);
      }
      return;
    }

    // CREATE MULTI-LANG
    setIsTranslating(true);
    toast.loading("Đang tạo bài học đa ngôn ngữ...");

    try {
      const languages = [
        { code: "Vietnam", name: "Tiếng Việt" },
        { code: "Korea", name: "Tiếng Hàn" },
        { code: "UK", name: "Tiếng Anh" },
      ];

      for (const lang of languages) {
        let translatedData = null;
        let translatedTitle = title;

        if (lang.code !== "Vietnam") {
          translatedTitle = await translateText(title, lang.name);

          if (category === "Từ vựng") {
            translatedData = await translateVocabularyQuestions(lang.name);
          } else if (category === "Ngữ pháp") {
            translatedData = await translateGrammarExamples(lang.name);
          }
        }

        const payload = {
          title: translatedTitle,
          description,
          category,
          level,
          prerequisiteLesson,
          mediaId: preview || null,
          exercises: buildExercises(lang.code, translatedData),
        };
        console.log("payload",payload);
        await saveLesson(payload);
      }

      toast.dismiss();
      toast.success("Tạo thành công 3 phiên bản ngôn ngữ!");
      onSave({ success: true });
      onClose();
    } catch (err) {
      toast.dismiss();
      toast.error("Có lỗi xảy ra khi tạo bài học!");
      console.error(err);
    } finally {
      setIsTranslating(false);
    }
  };

  // ==========================================================
  // RENDER
  // ==========================================================

  return (
    <div className="add-lesson-overlay">
      <div className="add-lesson-modal animate-slide-up">
        <div className="modal-header">
          <h3>{editingLesson ? "Cập nhật bài học" : "Thêm bài học mới"}</h3>
          <button className="close-btn" onClick={onClose}>
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="lesson-form">
          {/* Title */}
          <label>Tên bài học:</label>
          <input
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            required
          />

          {/* Description */}
          <label>Mô tả:</label>
          <textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            rows={3}
          />

          {/* Type */}
          <label>Phân loại chi tiết:</label>
          <input
            type="text"
            value={type}
            onChange={(e) => setType(e.target.value)}
            required
          />

          {/* Level */}
          <label>Độ khó:</label>
          <select value={level} onChange={(e) => setLevel(e.target.value)}>
            <option>Dễ</option>
            <option>Trung bình</option>
            <option>Khó</option>
          </select>

          {/* Prerequisite */}
          <label>Bài học yêu cầu trước:</label>
          <select
            value={prerequisiteLesson || ""}
            onChange={(e) => setPrerequisiteLesson(e.target.value || null)}
          >
            <option value="">Không</option>
            {lessonOptions.map((l) => (
              <option key={l.id} value={l.id}>
                {l.title}
              </option>
            ))}
          </select>

          {/* Category */}
          <label>Loại:</label>
          <select
            className="mb-2"
            value={category}
            onChange={(e) => setCategory(e.target.value)}
          >
            <option value="">Chọn Loại</option>
            <option value="Từ vựng">Từ vựng</option>
            <option value="Ngữ pháp">Ngữ pháp</option>
            <option value="Phát Âm">Phát Âm</option>
          </select>

          {/* Vocabulary UI */}
          {category === "Từ vựng" &&
            questions.map((q) => (
              <QuestionForm
                key={q.id}
                q={q}
                onChange={handleChangeQuestion}
                onDelete={handleDeleteQuestion}
              />
            ))}

          {category === "Từ vựng" && (
            <button
              type="button"
              className="add-question-btn"
              onClick={handleAddQuestion}
            >
              <Plus size={20} /> Thêm câu hỏi
            </button>
          )}

          {/* Grammar UI */}
          {category === "Ngữ pháp" && (
            <GrammarForm
              grammarRule={description}
              setGrammarRule={setDescription}
              examples={grammarExamples}
              setExamples={setGrammarExamples}
            />
          )}

          {/* Pronunciation UI */}
          {category === "Phát Âm" && (
            <PronunciationForm
              order={pronunciationOrder}
              setOrder={setPronunciationOrder}
              examples={pronunciationExamples}
              setExamples={setPronunciationExamples}
            />
          )}

          <button type="submit" className="save-btn" disabled={isTranslating}>
            <Save size={18} />
            {isTranslating
              ? "Đang xử lý..."
              : editingLesson
              ? "Cập nhật"
              : "Thêm bài học (3 ngôn ngữ)"}
          </button>
        </form>
      </div>
    </div>
  );
}
