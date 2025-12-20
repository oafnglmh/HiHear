import React from 'react';
import { Star, Award, RotateCcw } from 'lucide-react';

export const QuizResult = ({ score, totalQuestions, xpReward, onRetake, onBackToLessons }) => {
  const percentage = (score / totalQuestions) * 100;

  return (
    <div className="min-h-screen bg-gradient-to-br from-emerald-50 to-teal-50 py-12 px-4">
      <div className="max-w-2xl mx-auto">
        <div className="bg-white rounded-3xl shadow-2xl p-8 text-center">
          <div className="w-32 h-32 mx-auto mb-6 bg-gradient-to-br from-emerald-400 to-emerald-600 rounded-full flex items-center justify-center">
            <Star size={64} className="text-white" fill="white" />
          </div>

          <h2 className="text-3xl font-bold text-gray-900 mb-4">
            Hoàn thành bài học!
          </h2>

          <div className="bg-gradient-to-r from-emerald-50 to-teal-50 p-8 rounded-2xl mb-8">
            <div className="text-6xl font-extrabold text-emerald-600 mb-2">
              {score}/{totalQuestions}
            </div>
            <p className="text-gray-700 text-lg font-medium">
              Điểm số: {percentage.toFixed(0)}%
            </p>
          </div>

          <div className="flex items-center justify-center gap-2 mb-8">
            <Award size={24} className="text-amber-500" />
            <span className="text-2xl font-bold text-amber-600">
              +{xpReward} XP
            </span>
          </div>

          <div className="flex gap-4">
            <button
              onClick={onRetake}
              className="flex-1 py-4 rounded-2xl border-2 border-emerald-600 text-emerald-600 font-bold hover:bg-emerald-50 transition-all"
            >
              <RotateCcw size={20} className="inline mr-2" />
              Làm lại
            </button>
            <button
              onClick={onBackToLessons}
              className="flex-1 py-4 rounded-2xl bg-gradient-to-r from-emerald-600 to-emerald-700 text-white font-bold hover:from-emerald-700 hover:to-emerald-800 transition-all"
            >
              Về trang chủ
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};