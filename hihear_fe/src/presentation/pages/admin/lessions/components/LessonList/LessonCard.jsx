import React from "react";
import { Book, Edit3, Trash2 } from "lucide-react";
import { Card } from "../ui/Card";
import { Button } from "../ui/Button";

export const LessonCard = ({ lesson, onEdit, onDelete }) => {
  return (
    <Card hover className="group">
      <div className="p-6">
        <div className="flex items-start justify-between mb-4">
          <div className="flex items-center gap-3">
            <div className="p-3 bg-blue-100 rounded-lg">
              <Book size={24} className="text-blue-600" />
            </div>
            <div>
              <h3 className="font-semibold text-lg text-gray-900 group-hover:text-blue-600 transition-colors">
                {lesson.title}
              </h3>
              <p className="text-sm text-gray-500">{lesson.category}</p>
            </div>
          </div>
          <span className="px-3 py-1 bg-gray-100 rounded-full text-sm font-medium text-gray-700">
            {lesson.level}
          </span>
        </div>

        {lesson.description && (
          <p className="text-sm text-gray-600 mb-4 line-clamp-2">
            {lesson.description}
          </p>
        )}

        <div className="flex items-center gap-2 pt-4 border-t border-gray-100">
          <Button
            variant="ghost"
            size="sm"
            icon={Edit3}
            onClick={() => onEdit(lesson)}
          >
            Chỉnh sửa
          </Button>
          <Button
            variant="ghost"
            size="sm"
            icon={Trash2}
            onClick={() => onDelete(lesson)}
            className="text-red-600 hover:bg-red-50"
          >
            Xóa
          </Button>
        </div>
      </div>
    </Card>
  );
};