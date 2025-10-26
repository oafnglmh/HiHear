import { useState } from "react";

export function useLessonForm() {
  const [title, setTitle] = useState("");
  const [level, setLevel] = useState("Dễ");
  const [image, setImage] = useState(null);
  const [preview, setPreview] = useState(null);
  const [questions, setQuestions] = useState([
    { id: 1, text: "", optionA: "", optionB: "", correct: "A" },
  ]);

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setImage(file);
      setPreview(URL.createObjectURL(file));
    }
  };

  const handleAddQuestion = () => {
    setQuestions((prev) => [
      ...prev,
      { id: prev.length + 1, text: "", optionA: "", optionB: "", correct: "A" },
    ]);
  };

  const handleDeleteQuestion = (id) =>
    setQuestions((prev) => prev.filter((q) => q.id !== id));

  const handleChangeQuestion = (id, field, value) => {
    setQuestions((prev) =>
      prev.map((q) => (q.id === id ? { ...q, [field]: value } : q))
    );
  };

  return {
    title,
    setTitle,
    level,
    setLevel,
    image,
    preview,
    handleImageChange,
    questions,
    handleAddQuestion,
    handleDeleteQuestion,
    handleChangeQuestion,
  };
}
