import React, { useState, useEffect } from "react";
import { Plus, Book, Edit3, Trash2, X } from "lucide-react";
import AddLesson from "./AddLesson";
import apiClient from "../../../../../Core/config/apiClient";
import "../css/Lessons.css";
import { getLesson } from "../api/lessonApi";
import { deleteLesson } from "../services/lessonService";

import toast from "react-hot-toast";

export default function LessonsList() {
  const [lessons, setLessons] = useState([]);
  const [showAdd, setShowAdd] = useState(false);
  const [lessonOptions, setLessonOptions] = useState([]);
  const [showDeletePopup, setShowDeletePopup] = useState(false);
  const [lessonToDelete, setLessonToDelete] = useState(null);
  const [editingLesson, setEditingLesson] = useState(null);
  const fetchLessons = async () => {
    try {
      const res = await getLesson();
      const lessonsWithQuestions = res.data.map((l) => ({
        ...l,
        questions: l.questions || [],
      }));
      console.log("jdvnkvn",res)
      setLessons(lessonsWithQuestions);
      setLessonOptions(lessonsWithQuestions);
    } catch (err) {
      console.error("Fetch lessons error:", err);
    }
  };

  useEffect(() => {
    fetchLessons();
  }, []);

  const handleAddLesson = (newLesson) => {
    if (!newLesson) return;

    if (editingLesson) {
      setLessons((prev) =>
        prev.map((l) => (l.id === newLesson.id ? newLesson : l))
      );
    } else {
      setLessons((prev) => [...prev, newLesson]);
    }
  };


  const confirmDeleteLesson = (lesson) => {
    setLessonToDelete(lesson);
    setShowDeletePopup(true);
  };

  const handleDeleteConfirmed = async () => {
    try {
      await deleteLesson(lessonToDelete.id);
      setLessons(lessons.filter((l) => l.id !== lessonToDelete.id));
      toast.success("Xóa thành công");
    } catch (err) {
      console.error("Delete lesson error:", err);
    } finally {
      setShowDeletePopup(false);
      setLessonToDelete(null);
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
            style={{ background: l.color || "#93c5fd" }}
            onClick={() => setSelectedLesson(l)}
          >
            <div className="lesson-icon">
              <Book size={32} color="#fff" />
            </div>
            <h3>{l.title}</h3>
            <p className="lesson-level">Level: {l.level}</p>
            <div className="lesson-actions">
              <button
                className="edit-btn"
                onClick={(e) => {
                  e.stopPropagation();
                  setEditingLesson(l);
                  setShowAdd(true);
                }}
              >
                <Edit3 size={18} />
              </button>

              <button
                className="delete-btn"
                onClick={(e) => {
                  e.stopPropagation();
                  confirmDeleteLesson(l);
                }}
              >
                <Trash2 size={18} />
              </button>
            </div>
          </div>
        ))}
      </div>

      {showAdd && (
        <AddLesson
          onClose={() => {
            setShowAdd(false);
            setEditingLesson(null);
          }}
          onSave={handleAddLesson}
          lessonOptions={lessonOptions}
          editingLesson={editingLesson}
        />
      )}

      {showDeletePopup && lessonToDelete && (
        <div
          className="delete-popup-overlay"
          onClick={() => setShowDeletePopup(false)}
        >
          <div className="delete-popup" onClick={(e) => e.stopPropagation()}>
            <p>Bạn có chắc muốn xóa bài học "{lessonToDelete.title}" không?</p>
            <div className="popup-actions">
              <button onClick={handleDeleteConfirmed} className="confirm-btn">
                Xóa
              </button>
              <button
                onClick={() => setShowDeletePopup(false)}
                className="cancel-btn"
              >
                Hủy
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
