import { use, useState } from "react";

export function useLessonForm() {
  const [id, setId] = useState("");
  const [title, setTitle] = useState("");
  const [category, setCategory] = useState("");
  const [description, setDescription] = useState("");
  const [prerequisiteLesson, setPrerequisiteLesson] = useState(null);
  const [level, setLevel] = useState("Dễ");
  const [image, setImage] = useState(null);
  const [preview, setPreview] = useState(null);

  // Câu hỏi cho Vocabulary
  const [questions, setQuestions] = useState([
    { id: 1, text: "", optionA: "", optionB: "", correct: "A" },
  ]);

  // Grammar
  const [grammarDescription, setGrammarDescription] = useState("");
  const [grammarExamples, setGrammarExamples] = useState([]);

  // Pronunciation
  const [pronunciationOrder, setPronunciationOrder] = useState("");
  const [pronunciationExamples, setPronunciationExamples] = useState([]);

  // ================== IMAGE ==================
  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setImage(file);
      setPreview(URL.createObjectURL(file));
    }
  };

  // ================== VOCAB QUESTIONS ==================
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

  // ================== GRAMMAR ==================
  const handleAddGrammarExample = (example) => {
    setGrammarExamples((prev) => [...prev, example]);
  };

  const handleDeleteGrammarExample = (index) => {
    setGrammarExamples((prev) => prev.filter((_, i) => i !== index));
  };

  const handleChangeGrammarExample = (index, value) => {
    setGrammarExamples((prev) =>
      prev.map((ex, i) => (i === index ? value : ex))
    );
  };

  // ================== PRONUNCIATION ==================
  const handleAddPronunciationExample = (example) => {
    setPronunciationExamples((prev) => [...prev, example]);
  };

  const handleDeletePronunciationExample = (index) => {
    setPronunciationExamples((prev) => prev.filter((_, i) => i !== index));
  };

  const handleChangePronunciationExample = (index, value) => {
    setPronunciationExamples((prev) =>
      prev.map((ex, i) => (i === index ? value : ex))
    );
  };

  return {
    id,
    setId,
    title,
    setTitle,
    category,
    setCategory,
    description,
    setDescription,
    prerequisiteLesson,
    setPrerequisiteLesson,
    level,
    setLevel,
    image,
    preview,
    handleImageChange,
    questions,
    handleAddQuestion,
    handleDeleteQuestion,
    handleChangeQuestion,
    grammarDescription,
    setGrammarDescription,
    grammarExamples,
    handleAddGrammarExample,
    handleDeleteGrammarExample,
    handleChangeGrammarExample,
    pronunciationOrder,
    setPronunciationOrder,
    pronunciationExamples,
    handleAddPronunciationExample,
    handleDeletePronunciationExample,
    handleChangePronunciationExample,
  };
}
