import React, { useState } from "react";
import { Plus, Book, Edit3, Trash2, X } from "lucide-react";
import AddLesson from "./AddLesson";
import "../css/Lessons.css";

export default function LessonsList() {
  const [lessons, setLessons] = useState([
    {
      id: 1,
      title: "Chào hỏi",
      level: "Dễ",
      color: "#93c5fd",
      questions: [
        { text: "Hello nghĩa là gì?", optionA: "Xin chào", optionB: "Tạm biệt", correct: "A" },
      ],
    },
  ]);

  const [showAdd, setShowAdd] = useState(false);
  const [selectedLesson, setSelectedLesson] = useState(null);

  const handleAddLesson = (newLesson) => {
    setLessons([...lessons, { ...newLesson, id: lessons.length + 1 }]);
    setShowAdd(false);
  };

  const handleDeleteLesson = (id) => {
    if (window.confirm("Bạn có chắc muốn xóa bài học này?")) {
      setLessons(lessons.filter((l) => l.id !== id));
    }
  };

  return (
    <div className="lesson-admin-container">
      <div className="lesson-header">
        <h2>Danh sách bài học</h2>
        <button className="add-btn" onClick={() => setShowAdd(true)}>
          <Plus size={20} /> Thêm bài học
        </button>
      </div>

      <div className="lesson-grid">
        {lessons.map((l) => (
          <div
            key={l.id}
            className="lesson-card"
            style={{ background: l.color }}
            onClick={() => setSelectedLesson(l)}
          >
            <div className="lesson-icon">
              <Book size={32} color="#fff" />
            </div>
            <h3>{l.title}</h3>
            <p className="lesson-level">Level: {l.level}</p>
            <div className="lesson-actions">
              <button className="edit-btn">
                <Edit3 size={18} />
              </button>
              <button
                className="delete-btn"
                onClick={(e) => {
                  e.stopPropagation();
                  handleDeleteLesson(l.id);
                }}
              >
                <Trash2 size={18} />
              </button>
            </div>
          </div>
        ))}
      </div>

      {showAdd && <AddLesson onClose={() => setShowAdd(false)} onSave={handleAddLesson} />}

      {selectedLesson && (
        <div className="lesson-detail-overlay">
          <div className="lesson-detail-modal animate-slide-up">
            <div className="modal-header">
              <h3>{selectedLesson.title}</h3>
              <button className="close-btn" onClick={() => setSelectedLesson(null)}>
                <X size={20} />
              </button>
            </div>

            {selectedLesson.image && (
              <img src={selectedLesson.image} alt="lesson" className="detail-img" />
            )}

            <h4>Danh sách câu hỏi</h4>
            <ul className="question-list">
              {selectedLesson.questions?.map((q, i) => (
                <li key={i} className="question-item">
                  <strong>{q.text}</strong>
                  <p>A: {q.optionA}</p>
                  <p>B: {q.optionB}</p>
                  <p className="correct-answer">Đáp án đúng: {q.correct}</p>
                </li>
              ))}
            </ul>
          </div>
        </div>
      )}
    </div>
  );
}
