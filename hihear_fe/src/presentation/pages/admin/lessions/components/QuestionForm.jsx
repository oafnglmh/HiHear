import React from "react";
import { Trash2 } from "lucide-react";

export default function QuestionForm({ q, onChange, onDelete }) {
  return (
    <div className="question-item animate-fade-in">
      <input
        type="text"
        placeholder="Nhập câu hỏi..."
        value={q.text}
        onChange={(e) => onChange(q.id, "text", e.target.value)}
        required
      />
      <div className="options">
        <input
          type="text"
          placeholder="Đáp án A"
          value={q.optionA}
          onChange={(e) => onChange(q.id, "optionA", e.target.value)}
        />
        <input
          type="text"
          placeholder="Đáp án B"
          value={q.optionB}
          onChange={(e) => onChange(q.id, "optionB", e.target.value)}
        />
      </div>
      <label>
        Đáp án đúng:
        <select value={q.correct} onChange={(e) => onChange(q.id, "correct", e.target.value)}>
          <option value="A">A</option>
          <option value="B">B</option>
        </select>
      </label>
      <button type="button" onClick={() => onDelete(q.id)} className="delete-question-btn">
        <Trash2 size={16} />
      </button>
    </div>
  );
}
