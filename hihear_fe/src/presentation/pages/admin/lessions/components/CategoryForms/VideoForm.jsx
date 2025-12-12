import { Upload, X, Check, Loader } from "lucide-react";
import { Textarea } from "../ui/Select";
import { useState } from "react";
import { Input } from "../ui/Input";
import { Button } from "../ui/Button";
import { Card } from "../ui/Card";

export const VideoForm = ({ videoData, onChange }) => {
  const [isUploading, setIsUploading] = useState(false);

  const handleVideoUpload = async (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    if (!file.type.startsWith("video/")) {
      toast.error("Vui lòng chọn file video!");
      return;
    }

    if (file.size > 100 * 1024 * 1024) {
      toast.error("Video không được vượt quá 100MB!");
      return;
    }

    setIsUploading(true);
    const formData = new FormData();
    formData.append("file", file);

    try {
      const response = await fetch(
        "http://172.23.208.1:3000/api/v1/video/transcribe",
        {
          method: "POST",
          body: formData,
        }
      );

      if (!response.ok) throw new Error("Upload failed");

      const transcriptions = await response.json();

      onChange({
        fileName: file.name,
        fileSize: (file.size / (1024 * 1024)).toFixed(2) + " MB",
        transcriptions: transcriptions,
      });

      toast.success("Upload và transcribe thành công!");
    } catch (error) {
      console.error("Upload error:", error);
      toast.error("Có lỗi xảy ra khi xử lý video!");
    } finally {
      setIsUploading(false);
    }
  };

  const handleTranscriptionEdit = (index, lang, newValue) => {
    const updated = [...videoData.transcriptions];
    updated[index][lang] = newValue;
    onChange({ ...videoData, transcriptions: updated });
  };

  const handleDeleteSentence = (index) => {
    const updated = videoData.transcriptions.filter((_, i) => i !== index);
    onChange({ ...videoData, transcriptions: updated });
  };

  const handleAddSentence = () => {
    const newSentence = { vi: "", en: "", ko: "" };
    onChange({
      ...videoData,
      transcriptions: [...(videoData.transcriptions || []), newSentence],
    });
  };

  return (
    <div className="space-y-6">
      <Card>
        <div className="p-6">
          <label className="flex flex-col items-center gap-3 cursor-pointer hover:bg-gray-50 transition-colors rounded-lg p-6 border-2 border-dashed border-gray-300">
            <Upload size={32} className="text-gray-400" />
            <span className="text-sm font-medium text-gray-700">
              Chọn video để upload
            </span>
            <Input
              type="file"
              accept="video/*"
              onChange={handleVideoUpload}
              disabled={isUploading}
              className="hidden"
            />
          </label>

          {isUploading && (
            <div className="flex items-center gap-2 justify-center mt-4 text-blue-600">
              <Loader className="animate-spin" size={20} />
              <span>Đang xử lý video...</span>
            </div>
          )}

          {videoData?.fileName && !isUploading && (
            <div className="flex items-center gap-3 mt-4 p-3 bg-blue-50 rounded-lg">
              <Check size={20} className="text-green-600" />
              <div>
                <p className="font-medium text-gray-900">{videoData.fileName}</p>
                <p className="text-sm text-gray-600">{videoData.fileSize}</p>
              </div>
            </div>
          )}
        </div>
      </Card>

      {videoData?.transcriptions?.length > 0 && (
        <div className="space-y-4">
          <div className="flex items-center justify-between">
            <h4 className="text-lg font-semibold text-gray-900">
              Chỉnh sửa phiên âm
            </h4>
            <Button variant="secondary" icon={Plus} onClick={handleAddSentence}>
              Thêm câu mới
            </Button>
          </div>

          {videoData.transcriptions.map((item, index) => (
            <Card key={index}>
              <div className="p-4 space-y-3">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-medium text-gray-700">
                    Câu {index + 1}
                  </span>
                  <Button
                    variant="ghost"
                    size="sm"
                    icon={X}
                    onClick={() => handleDeleteSentence(index)}
                    className="text-red-600 hover:bg-red-50"
                  >
                    Xóa
                  </Button>
                </div>

                <Textarea
                  label="🇻🇳 Tiếng Việt"
                  value={item.vi}
                  onChange={(e) =>
                    handleTranscriptionEdit(index, "vi", e.target.value)
                  }
                  rows={2}
                  placeholder="Nhập nội dung tiếng Việt..."
                />

                <Textarea
                  label="🇬🇧 English"
                  value={item.en}
                  onChange={(e) =>
                    handleTranscriptionEdit(index, "en", e.target.value)
                  }
                  rows={2}
                  placeholder="Enter English content..."
                />

                <Textarea
                  label="🇰🇷 한국어"
                  value={item.ko}
                  onChange={(e) =>
                    handleTranscriptionEdit(index, "ko", e.target.value)
                  }
                  rows={2}
                  placeholder="한국어 내용을 입력하세요..."
                />
              </div>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
};