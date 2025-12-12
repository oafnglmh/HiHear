import { Button } from "../ui/Button";
import { Modal } from "../ui/Modal";

export const DeleteConfirmModal = ({ lesson, onConfirm, onCancel }) => {
  if (!lesson) return null;

  return (
    <Modal isOpen={!!lesson} onClose={onCancel} title="Xác nhận xóa" maxWidth="md">
      <div className="p-6 space-y-4">
        <p className="text-gray-700">
          Bạn có chắc muốn xóa bài học <strong>"{lesson.title}"</strong> không?
        </p>
        <p className="text-sm text-gray-500">Hành động này không thể hoàn tác.</p>

        <div className="flex items-center gap-3 justify-end pt-4">
          <Button variant="secondary" onClick={onCancel}>
            Hủy
          </Button>
          <Button variant="danger" onClick={onConfirm}>
            Xóa bài học
          </Button>
        </div>
      </div>
    </Modal>
  );
};