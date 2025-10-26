import React from "react";
import { X, Save, Plus, ImageIcon } from "lucide-react";
import { useLessonForm } from "../hooks/useLessonForm";
import QuestionForm from "./QuestionForm";
import "../css/Lessons.css";

export default function AddLesson({ onClose, onSave }) {
  const {
    title, setTitle,
    level, setLevel,
    preview, handleImageChange,
    questions, handleAddQuestion, handleDeleteQuestion, handleChangeQuestion,
  } = useLessonForm();

  const handleSubmit = (e) => {
    e.preventDefault();
    onSave({
      title,
      level,
      image: preview,
      color:
        level === "Dễ"
          ? "#93c5fd"
          : level === "Trung bình"
          ? "#6ee7b7"
          : "#f9a8d4",
      questions,
    });
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
          {preview && <img src={preview} alt="preview" className="image-preview" />}

          <h4>Câu hỏi trắc nghiệm</h4>
          {questions.map((q) => (
            <QuestionForm
              key={q.id}
              q={q}
              onChange={handleChangeQuestion}
              onDelete={handleDeleteQuestion}
            />
          ))}

          <button type="button" className="add-question-btn" onClick={handleAddQuestion}>
            <Plus size={20} /> Thêm câu hỏi
          </button>

          <button type="submit" className="save-btn">
            <Save size={18} /> Lưu bài học
          </button>
        </form>
      </div>
    </div>
  );
}
