import React, { useState } from "react";
import { Book, Plus } from "lucide-react";
import { useLessonList } from "../../hooks/useLessonList";
import { Button } from "../ui/Button";
import { LessonCard } from "./LessonCard";
import { DeleteConfirmModal } from "./DeleteConfirmModal";
import { LessonForm } from "../LessonForm/LessonForm";

export const LessonList = () => {
  const { lessons, loading, deleteLesson, fetchLessons } = useLessonList();
  const [showForm, setShowForm] = useState(false);
  const [editingLesson, setEditingLesson] = useState(null);
  const [deletingLesson, setDeletingLesson] = useState(null);

  const handleEdit = (lesson) => {
    setEditingLesson(lesson);
    setShowForm(true);
  };

  const handleDeleteClick = (lesson) => {
    setDeletingLesson(lesson);
  };

  const handleDeleteConfirm = async () => {
    if (!deletingLesson) return;
    await deleteLesson(deletingLesson.id);
    setDeletingLesson(null);
  };

  const handleFormClose = () => {
    setShowForm(false);
    setEditingLesson(null);
  };

  const handleFormSave = () => {
    fetchLessons();
    handleFormClose();
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin text-4xl">⏳</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <div className="max-w-7xl mx-auto">
        <div className="flex items-center justify-between mb-8">
          <div>
            <h1 className="text-3xl font-bold text-gray-900">Quản lý bài học</h1>
            <p className="text-gray-600 mt-1">
              Tổng cộng {lessons.length} bài học
            </p>
          </div>
          <Button icon={Plus} onClick={() => setShowForm(true)} size="lg">
            Thêm bài học
          </Button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {lessons.map((lesson) => (
            <LessonCard
              key={lesson.id}
              lesson={lesson}
              onEdit={handleEdit}
              onDelete={handleDeleteClick}
            />
          ))}
        </div>

        {lessons.length === 0 && (
          <div className="text-center py-16">
            <Book size={64} className="mx-auto text-gray-300 mb-4" />
            <h3 className="text-xl font-semibold text-gray-600 mb-2">
              Chưa có bài học nào
            </h3>
            <p className="text-gray-500 mb-6">
              Bắt đầu bằng cách tạo bài học đầu tiên
            </p>
            <Button icon={Plus} onClick={() => setShowForm(true)}>
              Tạo bài học
            </Button>
          </div>
        )}
      </div>

      {showForm && (
        <LessonForm
          lesson={editingLesson}
          lessonOptions={lessons}
          onClose={handleFormClose}
          onSave={handleFormSave}
        />
      )}

      <DeleteConfirmModal
        lesson={deletingLesson}
        onConfirm={handleDeleteConfirm}
        onCancel={() => setDeletingLesson(null)}
      />
    </div>
  );
};