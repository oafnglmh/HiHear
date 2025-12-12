import { Plus, Trash2 } from "lucide-react";
import { generateId } from "../../utils/idGenerator";
import { Button } from "../ui/Button";
import { Card } from "../ui/Card";
import { Input } from "../ui/Input";

export const PronunciationForm = ({ examples, order, onExamplesChange, onOrderChange }) => {
  const handleAdd = () => {
    onExamplesChange([...examples, { id: generateId(), text: "" }]);
  };

  const handleDelete = (id) => {
    onExamplesChange(examples.filter((ex) => ex.id !== id));
  };

  const handleChange = (id, value) => {
    onExamplesChange(
      examples.map((ex) => (ex.id === id ? { ...ex, text: value } : ex))
    );
  };

  return (
    <div className="space-y-4">
      <Input
        label="Số thứ tự bài đọc"
        type="number"
        placeholder="Nhập số thứ tự..."
        value={order}
        onChange={(e) => onOrderChange(e.target.value)}
        required
      />

      <div className="space-y-4">
        {examples.map((ex, index) => (
          <Card key={ex.id}>
            <div className="p-4 space-y-3">
              <div className="flex items-center justify-between mb-2">
                <span className="font-medium text-gray-700">
                  Câu {index + 1}
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
                placeholder="Nhập câu phát âm..."
                value={ex.text}
                onChange={(e) => handleChange(ex.id, e.target.value)}
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
          Thêm câu
        </Button>
      </div>
    </div>
  );
};