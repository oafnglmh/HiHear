import React, { useState } from "react";
import { Plus, Trash2, Volume2 } from "lucide-react";

export default function ListeningForm({ listenings, setListenings }) {

  const handleChange = (index, field, value) => {
    const updated = [...listenings];
    updated[index][field] = value;
    setListenings(updated);
  };

  const handleChoiceChange = (lIndex, cIndex, value) => {
    const updated = [...listenings];
    updated[lIndex].choices[cIndex] = value;
    setListenings(updated);
  };

  const addListening = () => {
    setListenings([
      ...listenings,
      {
        transcript: "",
        choices: ["", "", ""],
        correctAnswer: "",
      },
    ]);
  };

  const removeListening = (index) => {
    const updated = listenings.filter((_, i) => i !== index);
    setListenings(updated);
  };

  const addChoice = (lIndex) => {
    const updated = [...listenings];
    updated[lIndex].choices.push("");
    setListenings(updated);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-indigo-50 via-white to-purple-50 py-12 px-4">
      <div className="max-w-4xl mx-auto">

        <div className="space-y-6">
          {listenings.map((item, index) => (
            <div
              key={index}
              className="bg-white rounded-2xl shadow-lg hover:shadow-xl transition-shadow duration-300 overflow-hidden border border-gray-100"
            >
              <div className="bg-gradient-to-r from-indigo-500 to-purple-600 px-6 py-4 flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center text-white font-bold">
                    {index + 1}
                  </div>
                  <h3 className="text-white font-semibold text-lg">
                    Listening #{index + 1}
                  </h3>
                </div>
                <button
                  type="button"
                  onClick={() => removeListening(index)}
                  className="p-2 bg-white/20 hover:bg-white/30 backdrop-blur-sm rounded-xl transition-colors duration-200"
                >
                  <Trash2 size={18} className="text-white" />
                </button>
              </div>

              <div className="p-6 space-y-5">
                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-2">
                    Transcript
                  </label>
                  <textarea
                    value={item.transcript}
                    onChange={(e) =>
                      handleChange(index, "transcript", e.target.value)
                    }
                    placeholder="Nhập nội dung bài nghe..."
                    className="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-indigo-500 focus:ring-4 focus:ring-indigo-100 transition-all duration-200 resize-none"
                    rows="3"
                  />
                </div>

                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-3">
                    Các lựa chọn
                  </label>
                  <div className="space-y-3">
                    {item.choices.map((choice, cIndex) => (
                      <div key={cIndex} className="flex items-center gap-3">
                        <div className="flex-shrink-0 w-8 h-8 bg-gradient-to-br from-indigo-100 to-purple-100 rounded-lg flex items-center justify-center">
                          <span className="text-indigo-600 font-semibold text-sm">
                            {String.fromCharCode(65 + cIndex)}
                          </span>
                        </div>
                        <input
                          type="text"
                          value={choice}
                          placeholder={`Nhập lựa chọn ${cIndex + 1}`}
                          onChange={(e) =>
                            handleChoiceChange(index, cIndex, e.target.value)
                          }
                          className="flex-1 px-4 py-2.5 border-2 border-gray-200 rounded-xl focus:border-indigo-500 focus:ring-4 focus:ring-indigo-100 transition-all duration-200"
                        />
                      </div>
                    ))}
                  </div>

                  <button
                    type="button"
                    onClick={() => addChoice(index)}
                    className="mt-3 flex items-center gap-2 px-4 py-2 text-indigo-600 hover:bg-indigo-50 rounded-xl transition-colors duration-200 font-medium"
                  >
                    <Plus size={18} />
                    Thêm lựa chọn
                  </button>
                </div>

                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-2">
                    Đáp án đúng
                  </label>
                  <select
                    value={item.correctAnswer}
                    onChange={(e) =>
                      handleChange(index, "correctAnswer", e.target.value)
                    }
                    className="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-indigo-500 focus:ring-4 focus:ring-indigo-100 transition-all duration-200 bg-white cursor-pointer"
                  >
                    <option value="">Chọn đáp án đúng</option>
                    {item.choices.map((ch, i) => (
                      <option key={i} value={ch}>
                        {String.fromCharCode(65 + i)}. {ch || `Lựa chọn ${i + 1}`}
                      </option>
                    ))}
                  </select>
                </div>
              </div>
            </div>
          ))}
        </div>

        <button
          type="button"
          onClick={addListening}
          className="mt-8 w-full flex items-center justify-center gap-3 px-6 py-4 bg-gradient-to-r from-indigo-500 to-purple-600 hover:from-indigo-600 hover:to-purple-700 text-white font-semibold rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:scale-[1.02]"
        >
          <Plus size={22} />
          Thêm bài Listening mới
        </button>
      </div>
    </div>
  );
}