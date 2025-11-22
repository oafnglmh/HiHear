import React, { useState } from "react";
import { Upload, X, Check, Loader } from "lucide-react";
import toast from "react-hot-toast";

export default function VideoForm({ videoData, setVideoData }) {
  const [isUploading, setIsUploading] = useState(false);
  const [uploadProgress, setUploadProgress] = useState(0);

  const handleVideoUpload = async (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // Validate file type
    if (!file.type.startsWith("video/")) {
      toast.error("Vui lòng chọn file video!");
      return;
    }

    // Validate file size (max 100MB)
    if (file.size > 100 * 1024 * 1024) {
      toast.error("Video không được vượt quá 100MB!");
      return;
    }

    setIsUploading(true);
    const formData = new FormData();
    formData.append("file", file);

    try {
      // Upload và transcribe video
      const response = await fetch("http://172.23.208.1:3000/api/v1/video/transcribe", {
        method: "POST",
        body: formData,
      });

      if (!response.ok) {
        throw new Error("Upload failed");
      }

      const transcriptions = await response.json();
      
      setVideoData({
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
    setVideoData({ ...videoData, transcriptions: updated });
  };

  const handleDeleteSentence = (index) => {
    const updated = videoData.transcriptions.filter((_, i) => i !== index);
    setVideoData({ ...videoData, transcriptions: updated });
  };

  const handleAddSentence = () => {
    const newSentence = { vi: "", en: "", ko: "" };
    setVideoData({
      ...videoData,
      transcriptions: [...(videoData.transcriptions || []), newSentence],
    });
  };

  return (
    <div className="video-form-container">
      {/* Upload Section */}
      <div className="upload-section">
        <label className="upload-label">
          <Upload size={24} />
          <span>Chọn video để upload</span>
          <input
            type="file"
            accept="video/*"
            onChange={handleVideoUpload}
            disabled={isUploading}
            style={{ display: "none" }}
          />
        </label>

        {isUploading && (
          <div className="uploading-status">
            <Loader className="spinner" size={20} />
            <span>Đang xử lý video...</span>
          </div>
        )}

        {videoData?.fileName && !isUploading && (
          <div className="video-info">
            <Check size={20} className="success-icon" />
            <div>
              <p className="video-name">{videoData.fileName}</p>
              <p className="video-size">{videoData.fileSize}</p>
            </div>
          </div>
        )}
      </div>

      {/* Transcription Editor */}
      {videoData?.transcriptions?.length > 0 && (
        <div className="transcription-section">
          <h4>Chỉnh sửa phiên âm</h4>
          <p className="helper-text">
            Kiểm tra và chỉnh sửa các câu đã được transcribe tự động
          </p>

          {videoData.transcriptions.map((item, index) => (
            <div key={index} className="transcription-item">
              <div className="item-header">
                <span className="item-number">Câu {index + 1}</span>
                <button
                  type="button"
                  onClick={() => handleDeleteSentence(index)}
                  className="delete-btn"
                >
                  <X size={16} />
                </button>
              </div>

              <div className="lang-inputs">
                <div className="input-group">
                  <label>🇻🇳 Tiếng Việt:</label>
                  <textarea
                    value={item.vi}
                    onChange={(e) =>
                      handleTranscriptionEdit(index, "vi", e.target.value)
                    }
                    rows={2}
                    placeholder="Nhập nội dung tiếng Việt..."
                  />
                </div>

                <div className="input-group">
                  <label>🇬🇧 English:</label>
                  <textarea
                    value={item.en}
                    onChange={(e) =>
                      handleTranscriptionEdit(index, "en", e.target.value)
                    }
                    rows={2}
                    placeholder="Enter English content..."
                  />
                </div>

                <div className="input-group">
                  <label>🇰🇷 한국어:</label>
                  <textarea
                    value={item.ko}
                    onChange={(e) =>
                      handleTranscriptionEdit(index, "ko", e.target.value)
                    }
                    rows={2}
                    placeholder="한국어 내용을 입력하세요..."
                  />
                </div>
              </div>
            </div>
          ))}

          <button
            type="button"
            className="add-sentence-btn"
            onClick={handleAddSentence}
          >
            + Thêm câu mới
          </button>
        </div>
      )}

      <style jsx>{`
        .video-form-container {
          display: flex;
          flex-direction: column;
          gap: 20px;
        }

        .upload-section {
          border: 2px dashed #ddd;
          border-radius: 8px;
          padding: 20px;
          text-align: center;
        }

        .upload-label {
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 10px;
          cursor: pointer;
          color: #666;
          transition: color 0.3s;
        }

        .upload-label:hover {
          color: #4285f4;
        }

        .uploading-status {
          display: flex;
          align-items: center;
          gap: 10px;
          justify-content: center;
          margin-top: 10px;
          color: #4285f4;
        }

        .spinner {
          animation: spin 1s linear infinite;
        }

        @keyframes spin {
          from {
            transform: rotate(0deg);
          }
          to {
            transform: rotate(360deg);
          }
        }

        .video-info {
          display: flex;
          align-items: center;
          gap: 10px;
          margin-top: 10px;
          padding: 10px;
          background: #f0f9ff;
          border-radius: 6px;
        }

        .success-icon {
          color: #10b981;
        }

        .video-name {
          font-weight: 500;
          margin: 0;
        }

        .video-size {
          font-size: 0.875rem;
          color: #666;
          margin: 0;
        }

        .transcription-section {
          display: flex;
          flex-direction: column;
          gap: 15px;
        }

        .transcription-section h4 {
          margin: 0;
          font-size: 1.1rem;
        }

        .helper-text {
          color: #666;
          font-size: 0.875rem;
          margin: 0;
        }

        .transcription-item {
          border: 1px solid #e5e7eb;
          border-radius: 8px;
          padding: 15px;
          background: #fafafa;
        }

        .item-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 10px;
        }

        .item-number {
          font-weight: 600;
          color: #4285f4;
        }

        .delete-btn {
          background: none;
          border: none;
          color: #ef4444;
          cursor: pointer;
          padding: 4px;
          border-radius: 4px;
          transition: background 0.3s;
        }

        .delete-btn:hover {
          background: #fee;
        }

        .lang-inputs {
          display: flex;
          flex-direction: column;
          gap: 12px;
        }

        .input-group {
          display: flex;
          flex-direction: column;
          gap: 5px;
        }

        .input-group label {
          font-weight: 500;
          font-size: 0.9rem;
        }

        .input-group textarea {
          padding: 8px;
          border: 1px solid #ddd;
          border-radius: 4px;
          font-family: inherit;
          resize: vertical;
        }

        .input-group textarea:focus {
          outline: none;
          border-color: #4285f4;
        }

        .add-sentence-btn {
          padding: 10px 20px;
          background: #4285f4;
          color: white;
          border: none;
          border-radius: 6px;
          cursor: pointer;
          font-weight: 500;
          transition: background 0.3s;
        }

        .add-sentence-btn:hover {
          background: #3367d6;
        }
      `}</style>
    </div>
  );
}