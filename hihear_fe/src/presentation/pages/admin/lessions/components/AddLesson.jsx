import React, { useState } from "react";
import { X, Save, Plus, ImageIcon } from "lucide-react";
import { useLessonForm } from "../hooks/useLessonForm";
import QuestionForm from "./QuestionForm";
import "../css/Lessons.css";
import GrammarForm from "./GrammarForm";
import PronunciationForm from "./PronunciationForm";

export default function AddLesson({ onClose, onSave }) {
  const {
    title,
    setTitle,
    level,
    setLevel,
    preview,
    handleImageChange,
    questions,
    handleAddQuestion,
    handleDeleteQuestion,
    handleChangeQuestion,
  } = useLessonForm();

  const [type, setType] = useState("Từ vựng");

  // Ngữ pháp
  const [grammarDescription, setGrammarDescription] = useState("");
  const [grammarExamples, setGrammarExamples] = useState([]);

  // Phát âm
  const [pronunciationOrder, setPronunciationOrder] = useState("");
  const [pronunciationExamples, setPronunciationExamples] = useState([]);

  const handleSubmit = (e) => {
    e.preventDefault();

    const base = {
      title,
      level,
      type,
      image: preview,
      color:
        level === "Dễ"
          ? "#93c5fd"
          : level === "Trung bình"
          ? "#6ee7b7"
          : "#f9a8d4",
    };

    let payload = {};

    if (type === "Từ vựng") {
      payload = {
        ...base,
        questions,
      };
    } else if (type === "Ngữ pháp") {
      payload = {
        ...base,
        grammar: {
          description: grammarDescription,
          examples: grammarExamples,
        },
      };
    } else if (type === "Phát Âm") {
      payload = {
        ...base,
        pronunciation: {
          order: pronunciationOrder,
          examples: pronunciationExamples,
        },
      };
    }

    onSave(payload);
  };

  return (
    <div className="add-lesson-overlay">
      <div className="add-lesson-modal animate-slide-up">
        <div className="modal-header">
          <h3>Thêm bài học mới</h3>
          <button className="close-btn" onClick={onClose}>
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="lesson-form">
          <label>Tên bài học:</label>
          <input
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            required
          />

          <label>Độ khó:</label>
          <select value={level} onChange={(e) => setLevel(e.target.value)}>
            <option>Dễ</option>
            <option>Trung bình</option>
            <option>Khó</option>
          </select>

          <label>Loại:</label>
          <select value={type} onChange={(e) => setType(e.target.value)}>
            <option value="Từ vựng">Từ vựng</option>
            <option value="Ngữ pháp">Ngữ pháp</option>
            <option value="Phát Âm">Phát Âm</option>
          </select>

          <label>Ảnh minh họa:</label>
          <div className="image-upload">
            <input
              type="file"
              accept="image/*"
              id="upload-image"
              onChange={handleImageChange}
              hidden
            />
            <label htmlFor="upload-image" className="upload-btn">
              <ImageIcon size={20} />
            </label>
          </div>
          {preview && (
            <img src={preview} alt="preview" className="image-preview" />
          )}

          {/* ========== TỪ VỰNG ========== */}
          {type === "Từ vựng" && (
            <>
              <h4>Câu hỏi trắc nghiệm</h4>
              {questions.map((q) => (
                <QuestionForm
                  key={q.id}
                  q={q}
                  onChange={handleChangeQuestion}
                  onDelete={handleDeleteQuestion}
                />
              ))}

              <button
                type="button"
                className="add-question-btn"
                onClick={handleAddQuestion}
              >
                <Plus size={20} /> Thêm câu hỏi
              </button>
            </>
          )}

          {/* ========== NGỮ PHÁP ========== */}
          {type === "Ngữ pháp" && (
            <GrammarForm
              description={grammarDescription}
              setDescription={setGrammarDescription}
              examples={grammarExamples}
              setExamples={setGrammarExamples}
            />
          )}

          {/* ========== PHÁT ÂM ========== */}
          {type === "Phát Âm" && (
            <PronunciationForm
              order={pronunciationOrder}
              setOrder={setPronunciationOrder}
              examples={pronunciationExamples}
              setExamples={setPronunciationExamples}
            />
          )}

          <button type="submit" className="save-btn">
            <Save size={18} /> Lưu bài học
          </button>
        </form>
      </div>
    </div>
  );
}
