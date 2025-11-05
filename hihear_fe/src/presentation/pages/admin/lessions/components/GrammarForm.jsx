import React from "react";
import { Plus, Trash } from "lucide-react";

export default function GrammarForm({ description, setDescription, examples, setExamples }) {
  
  const handleAddExample = () => {
    setExamples([
      ...examples,
      { id: Date.now(), input: "", meaning: "" }
    ]);
  };

  const handleChangeExample = (id, field, value) => {
    setExamples((prev) =>
      prev.map((ex) => (ex.id === id ? { ...ex, [field]: value } : ex))
    );
  };

  const handleDeleteExample = (id) => {
    setExamples((prev) => prev.filter((ex) => ex.id !== id));
  };

  return (
    <div className="grammar-container">
      <h4 className="section-title">Nội dung ngữ pháp</h4>

      <textarea
        className="grammar-description"
        value={description}
        onChange={(e) => setDescription(e.target.value)}
        placeholder="Mô tả ngữ pháp..."
        rows={5}
      />

      <h4 className="section-title" style={{ marginTop: 12 }}>Ví dụ</h4>

      {examples.map((ex) => (
        <div key={ex.id} className="example-item">
          <input
            placeholder="Ví dụ"
            value={ex.input}
            onChange={(e) => handleChangeExample(ex.id, "input", e.target.value)}
          />

          <input
            placeholder="Ý nghĩa"
            value={ex.meaning}
            onChange={(e) => handleChangeExample(ex.id, "meaning", e.target.value)}
          />

          <button type="button" onClick={() => handleDeleteExample(ex.id)}>
            <Trash size={16} />
          </button>
        </div>
      ))}

      <button
        type="button"
        className="add-example-btn"
        onClick={handleAddExample}
      >
        <Plus size={16} /> Thêm ví dụ
      </button>
    </div>
  );
}
