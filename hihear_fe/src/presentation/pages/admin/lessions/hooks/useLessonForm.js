import { useState } from "react";

export function useLessonForm() {
  const [id, setId] = useState("");
  const [title, setTitle] = useState("");
  const [category, setCategory] = useState("");
  const [description, setDescription] = useState("");
  const [prerequisiteLesson, setPrerequisiteLesson] = useState(null);
  const [level, setLevel] = useState("Dễ");
  const [image, setImage] = useState(null);
  const [preview, setPreview] = useState(null);
  const [listenings, setListenings] = useState([]);
  const [grammarRule, setGrammarRule] = useState("");

  // ================== VOCABULARY ==================
  const [questions, setQuestions] = useState([
    { id: 1, text: "", optionA: "", optionB: "", correct: "A" },
  ]);

  const handleAddQuestion = () => {
    const newId = questions.length
      ? Math.max(...questions.map((q) => q.id)) + 1
      : 1;
    setQuestions((prev) => [
      ...prev,
      { id: newId, text: "", optionA: "", optionB: "", correct: "A" },
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
  const [grammarExamples, setGrammarExamples] = useState([]);
  const [grammarDescription, setGrammarDescription] = useState("");

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
  const [pronunciationExamples, setPronunciationExamples] = useState([]);
  const [pronunciationOrder, setPronunciationOrder] = useState(1);

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

  // ================== IMAGE ==================
  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setImage(file);
      setPreview(URL.createObjectURL(file));
    }
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
    setQuestions,
    handleAddQuestion,
    handleDeleteQuestion,
    handleChangeQuestion,
    grammarDescription,
    setGrammarDescription,
    grammarExamples,
    setGrammarExamples,
    handleAddGrammarExample,
    handleDeleteGrammarExample,
    handleChangeGrammarExample,
    pronunciationOrder,
    setPronunciationOrder,
    pronunciationExamples,
    setPronunciationExamples,
    handleAddPronunciationExample,
    handleDeletePronunciationExample,
    handleChangePronunciationExample,
    listenings,
    setListenings,
    grammarRule,
    setGrammarRule,
    grammarExamples,
    setGrammarExamples,
  };
}
