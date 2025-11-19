import React from "react";
import { Plus, Trash } from "lucide-react";

export default function PronunciationForm({ order, setOrder, examples, setExamples }) {

  const handleAdd = () => setExamples([...examples, { id: Date.now(), text: "" }]);
  const handleChange = (id, value) =>
    setExamples(examples.map(item => item.id === id ? { ...item, text: value } : item));
  const handleDelete = (id) => setExamples(examples.filter(item => item.id !== id));

  return (
    <div className="pronunciation-container">
      <h4 className="section-title">Bài đọc phát âm</h4>
      <label>Số thứ tự:</label>
      <input
        type="number"
        value={order}
        onChange={(e) => setOrder(e.target.value)}
        placeholder="Nhập số thứ tự bài đọc"
      />
      <h4 className="section-title" style={{ marginTop: 12 }}>Câu phát âm</h4>

      {examples.map(ex => (
        <div key={ex.id} className="example-item">
          <input
            placeholder="Nhập câu..."
            value={ex.text}
            onChange={(e) => handleChange(ex.id, e.target.value)}
          />
          <button type="button" onClick={() => handleDelete(ex.id)}>
            <Trash size={16} />
          </button>
        </div>
      ))}

      <button type="button" className="add-example-btn" onClick={handleAdd}>
        <Plus size={16} /> Thêm câu
      </button>
    </div>
  );
}
