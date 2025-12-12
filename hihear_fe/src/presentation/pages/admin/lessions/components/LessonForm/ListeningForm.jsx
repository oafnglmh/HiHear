import { Plus, Trash2 } from "lucide-react";
import { Button } from "../ui/Button";
import { Select, Textarea } from "../ui/Select";
import { Card } from "../ui/Card";
import { Input } from "../ui/Input";

export const ListeningForm = ({ listenings, onChange }) => {
  const handleAdd = () => {
    onChange([
      ...listenings,
      { transcript: "", choices: ["", "", ""], correctAnswer: "" },
    ]);
  };

  const handleDelete = (index) => {
    onChange(listenings.filter((_, i) => i !== index));
  };

  const handleChange = (index, field, value) => {
    onChange(
      listenings.map((item, i) =>
        i === index ? { ...item, [field]: value } : item
      )
    );
  };

  const handleChoiceChange = (lIndex, cIndex, value) => {
    const updated = [...listenings];
    updated[lIndex].choices[cIndex] = value;
    onChange(updated);
  };

  const addChoice = (lIndex) => {
    const updated = [...listenings];
    updated[lIndex].choices.push("");
    onChange(updated);
  };

  return (
    <div className="space-y-4">
      {listenings.map((item, index) => (
        <Card key={index}>
          <div className="p-4 space-y-3">
            <div className="flex items-center justify-between mb-2">
              <span className="font-medium text-gray-700">
                Bài nghe {index + 1}
              </span>
              <Button
                variant="ghost"
                size="sm"
                icon={Trash2}
                onClick={() => handleDelete(index)}
                className="text-red-600 hover:bg-red-50"
              >
                Xóa
              </Button>
            </div>

            <Textarea
              label="Transcript"
              placeholder="Nhập nội dung bài nghe..."
              value={item.transcript}
              onChange={(e) => handleChange(index, "transcript", e.target.value)}
              rows={3}
              required
            />

            <div className="space-y-2">
              <label className="block text-sm font-medium text-gray-700">
                Các lựa chọn
              </label>
              {item.choices.map((choice, cIndex) => (
                <div key={cIndex} className="flex items-center gap-2">
                  <span className="flex-shrink-0 w-8 h-8 flex items-center justify-center bg-blue-100 rounded-lg text-blue-600 font-medium text-sm">
                    {String.fromCharCode(65 + cIndex)}
                  </span>
                  <Input
                    placeholder={`Nhập lựa chọn ${cIndex + 1}`}
                    value={choice}
                    onChange={(e) =>
                      handleChoiceChange(index, cIndex, e.target.value)
                    }
                    required
                  />
                </div>
              ))}
              <Button
                variant="ghost"
                size="sm"
                icon={Plus}
                onClick={() => addChoice(index)}
              >
                Thêm lựa chọn
              </Button>
            </div>

            <Select
              label="Đáp án đúng"
              value={item.correctAnswer}
              onChange={(e) =>
                handleChange(index, "correctAnswer", e.target.value)
              }
              required
            >
              <option value="">Chọn đáp án đúng</option>
              {item.choices.map((ch, i) => (
                <option key={i} value={ch}>
                  {String.fromCharCode(65 + i)}. {ch || `Lựa chọn ${i + 1}`}
                </option>
              ))}
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
        Thêm bài nghe
      </Button>
    </div>
  );
};