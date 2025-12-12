import { Check } from "lucide-react";
import { Button } from "../ui/Button";
import { Select } from "../ui/Select";
import { useState } from "react";
import { Modal } from "../ui/Modal";

export const PrerequisiteModal = ({
  isOpen,
  languages,
  currentIndex,
  lessonOptions,
  onSelect,
  onClose,
}) => {
  const [selectedLesson, setSelectedLesson] = useState("");

  if (!isOpen) return null;

  const currentLang = languages[currentIndex];

  const handleConfirm = () => {
    onSelect(selectedLesson || null);
    setSelectedLesson("");
  };

  return (
    <Modal isOpen={isOpen} onClose={onClose} title="Chọn bài học yêu cầu trước" maxWidth="md">
      <div className="p-6 space-y-4">
        <div className="p-4 bg-blue-50 rounded-lg">
          <p className="text-sm text-gray-600 mb-1">Ngôn ngữ:</p>
          <p className="text-lg font-semibold text-gray-900">
            {currentLang.name} ({currentIndex + 1}/{languages.length})
          </p>
        </div>

        <Select
          label="Bài học yêu cầu trước"
          value={selectedLesson}
          onChange={(e) => setSelectedLesson(e.target.value)}
        >
          <option value="">Không có</option>
          {lessonOptions.map((l) => (
            <option key={l.id} value={l.id}>
              {l.title}
            </option>
          ))}
        </Select>

        <div className="flex items-center gap-3 justify-end pt-4">
          <Button variant="secondary" onClick={onClose}>
            Hủy
          </Button>
          <Button icon={Check} onClick={handleConfirm}>
            Xác nhận
          </Button>
        </div>
      </div>
    </Modal>
  );
};