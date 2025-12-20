import React, { useState, useEffect } from 'react';
import { X, Check, AlertCircle } from 'lucide-react';

export const GameChallengeModal = ({
  challenge,
  onSuccess,
  onFail,
  onClose
}) => {
  const [selectedAnswer, setSelectedAnswer] = useState(null);
  const [showResult, setShowResult] = useState(false);
  const [isCorrect, setIsCorrect] = useState(false);

  const handleSubmit = () => {
    if (!selectedAnswer) return;

    const correct = selectedAnswer === challenge.correctAnswer;
    setIsCorrect(correct);
    setShowResult(true);

    setTimeout(() => {
      if (correct) {
        onSuccess();
      } else {
        onFail();
      }
      onClose();
    }, 2000);
  };

  if (!challenge) return null;

  return (
    <div className="fixed inset-0 bg-black/70 backdrop-blur-sm flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-3xl p-8 max-w-2xl w-full shadow-2xl transform transition-all">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 bg-gradient-to-br from-amber-400 to-orange-500 rounded-full flex items-center justify-center">
              <span className="text-2xl">🏰</span>
            </div>
            <div>
              <h3 className="text-2xl font-bold text-gray-900">
                Thử thách {challenge.gateNumber}
              </h3>
              <p className="text-sm text-gray-600">Hoàn thành để tiếp tục!</p>
            </div>
          </div>
        </div>

        {!showResult ? (
          <>
            <div className="bg-gradient-to-r from-blue-50 to-indigo-50 p-6 rounded-2xl mb-6 border-2 border-blue-200">
              <p className="text-gray-600 text-sm mb-2 font-medium">
                Translation:
              </p>
              <p className="text-lg text-gray-900 font-medium mb-4">
                {challenge.translation}
              </p>
              <div className="h-px bg-blue-200 mb-4"></div>
              <p className="text-gray-700 text-sm mb-2 font-medium">
                Điền từ vào chỗ trống:
              </p>
              <p className="text-3xl font-bold text-gray-900 leading-relaxed">
                {challenge.sentence}
              </p>
            </div>

            <div className="space-y-3 mb-6">
              {challenge.options.map((option, idx) => (
                <button
                  key={idx}
                  onClick={() => setSelectedAnswer(option)}
                  className={`w-full p-4 rounded-2xl border-2 text-left font-medium text-lg transition-all transform hover:scale-105 ${
                    selectedAnswer === option
                      ? 'border-emerald-500 bg-emerald-50 text-emerald-900 shadow-md'
                      : 'border-gray-200 hover:border-emerald-300 bg-white text-gray-700'
                  }`}
                >
                  <div className="flex items-center gap-3">
                    <div
                      className={`w-8 h-8 rounded-full border-2 flex items-center justify-center text-sm font-bold ${
                        selectedAnswer === option
                          ? 'border-emerald-500 bg-emerald-500 text-white'
                          : 'border-gray-300 text-gray-400'
                      }`}
                    >
                      {String.fromCharCode(65 + idx)}
                    </div>
                    <span>{option}</span>
                  </div>
                </button>
              ))}
            </div>

            <button
              onClick={handleSubmit}
              disabled={!selectedAnswer}
              className={`w-full py-4 rounded-2xl font-bold text-lg transition-all transform ${
                selectedAnswer
                  ? 'bg-gradient-to-r from-emerald-600 to-emerald-700 text-white hover:from-emerald-700 hover:to-emerald-800 hover:scale-105 active:scale-95'
                  : 'bg-gray-200 text-gray-400 cursor-not-allowed'
              }`}
            >
              Xác nhận đáp án
            </button>
          </>
        ) : (
          <div className="text-center py-8">
            {isCorrect ? (
              <>
                <div className="w-24 h-24 mx-auto mb-6 bg-gradient-to-br from-green-400 to-emerald-600 rounded-full flex items-center justify-center">
                  <Check size={48} className="text-white" />
                </div>
                <h3 className="text-3xl font-bold text-green-600 mb-2">
                  Chính xác!
                </h3>
                <p className="text-gray-600 text-lg">
                  Bạn đã vượt qua thử thách này!
                </p>
              </>
            ) : (
              <>
                <div className="w-24 h-24 mx-auto mb-6 bg-gradient-to-br from-red-400 to-rose-600 rounded-full flex items-center justify-center">
                  <X size={48} className="text-white" />
                </div>
                <h3 className="text-3xl font-bold text-red-600 mb-2">
                  Sai rồi!
                </h3>
                <p className="text-gray-600 text-lg mb-2">
                  Đáp án đúng là: <span className="font-bold text-emerald-600">{challenge.correctAnswer}</span>
                </p>
                <p className="text-gray-500">
                  Trò chơi kết thúc. Hãy thử lại vào ngày mai!
                </p>
              </>
            )}
          </div>
        )}
      </div>
    </div>
  );
};