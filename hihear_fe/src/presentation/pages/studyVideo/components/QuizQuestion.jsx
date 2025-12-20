import React from 'react';
import { Check } from 'lucide-react';
import { LANGUAGE_LABELS } from '../utils/constants';

export const QuizQuestion = ({
  question,
  currentIndex,
  totalQuestions,
  selectedAnswer,
  onSelectAnswer,
  onNext,
  national,
}) => {
  const languageLabel = LANGUAGE_LABELS[national] || 'Vietnamese';

  return (
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 to-teal-50 py-12 px-4">
      <div className="max-w-3xl mx-auto">
        <div className="bg-white rounded-3xl shadow-2xl p-8">
          <div className="flex items-center justify-between mb-8">
            <h2 className="text-2xl font-bold text-gray-900">
              Bài kiểm tra từ vựng
            </h2>
            <div className="text-emerald-600 font-bold text-lg">
              Câu {currentIndex + 1}/{totalQuestions}
            </div>
          </div>

          <div className="mb-8">
            <div className="bg-gradient-to-r from-blue-50 to-indigo-50 p-6 rounded-2xl mb-6 border border-blue-200">
              <p className="text-gray-600 text-sm mb-2 font-medium">
                {languageLabel}:
              </p>
              <p className="text-xl text-gray-900 font-medium">
                {question.englishText}
              </p>
            </div>

            <p className="text-gray-700 mb-2 text-sm font-medium">
              Điền vào chỗ trống:
            </p>
            <p className="text-2xl font-bold text-gray-900 mb-8 leading-relaxed">
              {question.sentence}
            </p>

            <div className="space-y-4">
              {question.options.map((option, idx) => (
                <button
                  key={idx}
                  onClick={() => onSelectAnswer(option)}
                  className={`w-full p-5 rounded-2xl border-2 text-left font-medium text-lg transition-all transform hover:scale-105 ${
                    selectedAnswer === option
                      ? 'border-emerald-500 bg-emerald-50 text-emerald-900'
                      : 'border-gray-200 hover:border-emerald-300 bg-white text-gray-700'
                  }`}
                >
                  <div className="flex items-center gap-3">
                    <div
                      className={`w-6 h-6 rounded-full border-2 flex items-center justify-center ${
                        selectedAnswer === option
                          ? 'border-emerald-500 bg-emerald-500'
                          : 'border-gray-300'
                      }`}
                    >
                      {selectedAnswer === option && (
                        <Check size={16} className="text-white" />
                      )}
                    </div>
                    <span>{option}</span>
                  </div>
                </button>
              ))}
            </div>
          </div>

          <button
            onClick={onNext}
            disabled={!selectedAnswer}
            className={`w-full py-4 rounded-2xl font-bold text-lg transition-all transform ${
              selectedAnswer
                ? 'bg-gradient-to-r from-emerald-600 to-emerald-700 text-white hover:from-emerald-700 hover:to-emerald-800 hover:scale-105 active:scale-95'
                : 'bg-gray-200 text-gray-400 cursor-not-allowed'
            }`}
          >
            {currentIndex < totalQuestions - 1 ? 'Câu tiếp theo' : 'Xem kết quả'}
          </button>
        </div>
      </div>
    </div>
  );
};