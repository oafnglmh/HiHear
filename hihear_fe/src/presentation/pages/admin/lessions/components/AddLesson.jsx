import React, { useState } from "react";
import { X, Save, Plus, ImageIcon } from "lucide-react";
import { useLessonForm } from "../hooks/useLessonForm";
import QuestionForm from "./QuestionForm";
import "../css/Lessons.css";
import GrammarForm from "./GrammarForm";
import PronunciationForm from "./PronunciationForm";
import { saveLesson, editLesson } from "../services/lessonService";
import toast from "react-hot-toast";
import { useEffect } from "react";
export default function AddLesson({
  onClose,
  onSave,
  lessonOptions = [],
  editingLesson = null,
}) {
  const {
    id,
    setId,
    title,
    setTitle,
    category,
    setCategory,
    level,
    setLevel,
    preview,
    handleImageChange,
    questions,
    handleAddQuestion,
    handleDeleteQuestion,
    handleChangeQuestion,
  } = useLessonForm();

  const [type, setType] = useState("Từ vựng");

  const [description, setDescription] = useState("");
  const [prerequisiteLesson, setPrerequisiteLesson] = useState(null);

  const [grammarDescription, setGrammarDescription] = useState("");
  const [grammarExamples, setGrammarExamples] = useState([]);

  const [pronunciationOrder, setPronunciationOrder] = useState("");
  const [pronunciationExamples, setPronunciationExamples] = useState([]);
  useEffect(() => {
    console.log("lession option",editingLesson);
    if (editingLesson) {
      setId(editingLesson.id || "");
      setTitle(editingLesson.title || "");
      setCategory(editingLesson.category || "");
      setLevel(editingLesson.level || "Dễ");
      setDescription(editingLesson.description || "");
      setPrerequisiteLesson(editingLesson.prerequisiteLesson || null);
      setType(editingLesson.type || "Từ vựng");

      // if (editingLesson.questions) {
      //   setQuestions(editingLesson.questions);
      // }

      if (editingLesson.grammar) {
        setGrammarDescription(editingLesson.grammar.description || "");
        setGrammarExamples(editingLesson.grammar.examples || []);
      }

      if (editingLesson.pronunciation) {
        setPronunciationOrder(editingLesson.pronunciation.order || "");
        setPronunciationExamples(editingLesson.pronunciation.examples || []);
      }
    }
  }, [editingLesson]);
  const handleSubmit = async (e) => {
    e.preventDefault();

    const base = {
      title,
      description,
      category,
      level,
      type,
      prerequisiteLesson,
      image: preview,
      color:
        level === "Dễ"
          ? "#93c5fd"
          : level === "Trung bình"
          ? "#6ee7b7"
          : "#f9a8d4",
    };
    console.log("dataaaaa", base)
    let payload = {};
    if (type === "Từ vựng") payload = { ...base, questions };
    else if (type === "Ngữ pháp")
      payload = {
        ...base,
        grammar: { description: grammarDescription, examples: grammarExamples },
      };
    else if (type === "Phát Âm")
      payload = {
        ...base,
        pronunciation: {
          order: pronunciationOrder,
          examples: pronunciationExamples,
        },
      };

    try {
      let result;
      if (editingLesson) {
        result = await editLesson(payload,id);
        toast.success("Cập nhật thành công!");
      } else {
        result = await saveLesson(payload);
        toast.success("Thêm thành công!");
      }

      onSave(result.data);
      onClose();
    } catch (err) {
      toast.error(editingLesson ? "Cập nhật thất bại!" : "Thêm thất bại!");
      console.error(err);
    }
  };

  return (
    <div className="add-lesson-overlay">
      <div className="add-lesson-modal animate-slide-up">
        <div className="modal-header">
          <h3>{editingLesson ? "Cập nhật bài học" : "Thêm bài học mới"}</h3>

          <button className="close-btn" onClick={onClose}>
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="lesson-form">
          <label>Tên bài học:</label>
          <input
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            required
          />

          <label>Mô tả:</label>
          <textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            rows={3}
          />

          <label>Phân loại:</label>
          <input
            type="text"
            value={category}
            onChange={(e) => setCategory(e.target.value)}
            required
          />

          <label>Độ khó:</label>
          <select value={level} onChange={(e) => setLevel(e.target.value)}>
            <option>Dễ</option>
            <option>Trung bình</option>
            <option>Khó</option>
          </select>

          <label>Bài học yêu cầu trước:</label>
          <select
            value={prerequisiteLesson || ""}
            onChange={(e) => setPrerequisiteLesson(e.target.value || null)}
          >
            <option value="">Không</option>
            {lessonOptions.map((l) => (
              <option key={l.id} value={l.id}>
                {l.title}
              </option>
            ))}
          </select>

          <label>Loại:</label>
          <select value={type} onChange={(e) => setType(e.target.value)}>
            <option value="Từ vựng">Từ vựng</option>
            <option value="Ngữ pháp">Ngữ pháp</option>
            <option value="Phát Âm">Phát Âm</option>
          </select>

          <label>Ảnh minh họa:</label>
          <div className="image-upload">
            <input
              type="file"
              accept="image/*"
              id="upload-image"
              onChange={handleImageChange}
              hidden
            />
            <label htmlFor="upload-image" className="upload-btn">
              <ImageIcon size={20} />
            </label>
          </div>
          {preview && (
            <img src={preview} alt="preview" className="image-preview" />
          )}

          {type === "Từ vựng" && (
            <>
              <h4>Câu hỏi trắc nghiệm</h4>
              {questions.map((q) => (
                <QuestionForm
                  key={q.id}
                  q={q}
                  onChange={handleChangeQuestion}
                  onDelete={handleDeleteQuestion}
                />
              ))}

              <button
                type="button"
                className="add-question-btn"
                onClick={handleAddQuestion}
              >
                <Plus size={20} /> Thêm câu hỏi
              </button>
            </>
          )}

          {type === "Ngữ pháp" && (
            <GrammarForm
              description={grammarDescription}
              setDescription={setGrammarDescription}
              examples={grammarExamples}
              setExamples={setGrammarExamples}
            />
          )}

          {type === "Phát Âm" && (
            <PronunciationForm
              order={pronunciationOrder}
              setOrder={setPronunciationOrder}
              examples={pronunciationExamples}
              setExamples={setPronunciationExamples}
            />
          )}

          <button type="submit" className="save-btn">
            <Save size={18} />{editingLesson ? "Cập nhật" : "Thêm bài học"}

          </button>
        </form>
      </div>
    </div>
  );
}
