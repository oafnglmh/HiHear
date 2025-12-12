import React from "react";
import { Plus, Trash2 } from "lucide-react";
import { Button } from "../ui/Button";
import { Select } from "../ui/Select";
import { Input } from "../ui/Input";
import { Card } from "../ui/Card";
import { generateId } from "../../utils/idGenerator";

export const VocabularyForm = ({ questions, onChange }) => {
  const handleAdd = () => {
    onChange([
      ...questions,
      {
        id: generateId(),
        text: "",
        optionA: "",
        optionB: "",
        correct: "A",
      },
    ]);
  };

  const handleDelete = (id) => {
    onChange(questions.filter((q) => q.id !== id));
  };

  const handleChange = (id, field, value) => {
    onChange(
      questions.map((q) => (q.id === id ? { ...q, [field]: value } : q))
    );
  };

  return (
    <div className="space-y-4">
      {questions.map((q, index) => (
        <Card key={q.id}>
          <div className="p-4 space-y-3">
            <div className="flex items-center justify-between mb-2">
              <span className="font-medium text-gray-700">Câu {index + 1}</span>
              <Button
                variant="ghost"
                size="sm"
                icon={Trash2}
                onClick={() => handleDelete(q.id)}
                className="text-red-600 hover:bg-red-50"
              >
                Xóa
              </Button>
            </div>

            <Input
              label="Câu hỏi"
              placeholder="Nhập câu hỏi..."
              value={q.text}
              onChange={(e) => handleChange(q.id, "text", e.target.value)}
              required
            />

            <div className="grid grid-cols-2 gap-3">
              <Input
                label="Đáp án A"
                placeholder="Nhập đáp án A..."
                value={q.optionA}
                onChange={(e) => handleChange(q.id, "optionA", e.target.value)}
                required
              />
              <Input
                label="Đáp án B"
                placeholder="Nhập đáp án B..."
                value={q.optionB}
                onChange={(e) => handleChange(q.id, "optionB", e.target.value)}
                required
              />
            </div>

            <Select
              label="Đáp án đúng"
              value={q.correct}
              onChange={(e) => handleChange(q.id, "correct", e.target.value)}
              required
            >
              <option value="A">A</option>
              <option value="B">B</option>
            </Select>
          </div>
        </Card>
      ))}

      <Button
        variant="secondary"
        icon={Plus}
        onClick={handleAdd}
        className="w-full"
      >
        Thêm câu hỏi
      </Button>
    </div>
  );
};
