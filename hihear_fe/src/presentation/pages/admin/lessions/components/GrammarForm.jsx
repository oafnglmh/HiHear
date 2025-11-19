import React from "react";
import { Plus, Trash } from "lucide-react";

export default function GrammarForm({ grammarRule, setGrammarRule, examples, setExamples }) {

  const handleAdd = () =>
    setExamples([
      ...examples,
      { id: Date.now(), example: "", meaning: "" }
    ]);

  const handleChange = (id, field, value) =>
    setExamples(
      examples.map((ex) =>
        ex.id === id ? { ...ex, [field]: value } : ex
      )
    );

  const handleDelete = (id) =>
    setExamples(examples.filter((ex) => ex.id !== id));

  return (
    <div className="grammar-container">
      <h4 className="section-title">Nội dung ngữ pháp</h4>

      {/* grammarRule = nội dung mô tả ngữ pháp */}
      <textarea
        className="grammar-description"
        value={grammarRule}
        onChange={(e) => setGrammarRule(e.target.value)}
        placeholder="Mô tả ngữ pháp (grammarRule)..."
        rows={4}
      />

      <h4 className="section-title" style={{ marginTop: 12 }}>Ví dụ</h4>

      {examples.map((ex) => (
        <div key={ex.id} className="example-item">

          <input
            placeholder="Ví dụ (example)"
            value={ex.example}
            onChange={(e) => handleChange(ex.id, "example", e.target.value)}
          />

          <input
            placeholder="Ý nghĩa (meaning)"
            value={ex.meaning}
            onChange={(e) => handleChange(ex.id, "meaning", e.target.value)}
          />

          <button type="button" onClick={() => handleDelete(ex.id)}>
            <Trash size={16} />
          </button>

        </div>
      ))}

      <button type="button" className="add-example-btn" onClick={handleAdd}>
        <Plus size={16} /> Thêm ví dụ
      </button>
    </div>
  );
}
