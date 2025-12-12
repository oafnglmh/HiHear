import { Plus, Trash2 } from "lucide-react";
import { Button } from "../ui/Button";
import { Card } from "../ui/Card";
import { Input } from "../ui/Input";
import { generateId } from "../../utils/idGenerator";

export const GrammarForm = ({ examples, onChange }) => {
  const handleAdd = () => {
    onChange([
      ...examples,
      { id: generateId(), grammarRule: "", example: "", meaning: "" },
    ]);
  };

  const handleDelete = (id) => {
    onChange(examples.filter((ex) => ex.id !== id));
  };

  const handleChange = (id, field, value) => {
    onChange(
      examples.map((ex) => (ex.id === id ? { ...ex, [field]: value } : ex))
    );
  };

  return (
    <div className="space-y-4">
      {examples.map((ex, index) => (
        <Card key={ex.id}>
          <div className="p-4 space-y-3">
            <div className="flex items-center justify-between mb-2">
              <span className="font-medium text-gray-700">
                Ví dụ {index + 1}
              </span>
              <Button
                variant="ghost"
                size="sm"
                icon={Trash2}
                onClick={() => handleDelete(ex.id)}
                className="text-red-600 hover:bg-red-50"
              >
                Xóa
              </Button>
            </div>

            <Input
              label="Quy tắc ngữ pháp"
              placeholder="Nhập quy tắc..."
              value={ex.grammarRule}
              onChange={(e) =>
                handleChange(ex.id, "grammarRule", e.target.value)
              }
              required
            />

            <Input
              label="Ví dụ"
              placeholder="Nhập ví dụ..."
              value={ex.example}
              onChange={(e) => handleChange(ex.id, "example", e.target.value)}
              required
            />

            <Input
              label="Ý nghĩa"
              placeholder="Nhập ý nghĩa..."
              value={ex.meaning}
              onChange={(e) => handleChange(ex.id, "meaning", e.target.value)}
              required
            />
          </div>
        </Card>
      ))}

      <Button
        variant="secondary"
        icon={Plus}
        onClick={handleAdd}
        className="w-full"
      >
        Thêm ví dụ
      </Button>
    </div>
  );
};