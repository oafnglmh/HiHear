import React from 'react';
import { PlayCircle, Heart } from 'lucide-react';

export const PageHeader = ({ remainingLessons, maxLessons = 5 }) => {
  return (
    <div className="relative bg-gradient-to-br from-emerald-700 via-emerald-600 to-teal-600 overflow-hidden">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20 relative z-10">
        <div className="flex flex-wrap items-center gap-3 mb-6">
          <div className="inline-flex items-center gap-2 bg-white/20 backdrop-blur-md px-5 py-2 rounded-full border border-white/30">
            <PlayCircle size={20} className="text-amber-200" />
            <span className="text-white font-semibold text-sm">
              BÀI HỌC QUA VIDEO
            </span>
          </div>

          <div
            className={`inline-flex items-center gap-2 backdrop-blur-md px-5 py-2 rounded-full border-2 ${
              remainingLessons > 0
                ? 'bg-emerald-500/20 border-emerald-400/50'
                : 'bg-rose-500/20 border-rose-400/50'
            }`}
          >
            <Heart
              size={18}
              className={
                remainingLessons > 0 ? 'text-emerald-300' : 'text-rose-300'
              }
              fill="currentColor"
            />
            <span className="text-white font-bold text-sm">
              {remainingLessons}/{maxLessons} lượt học
            </span>
          </div>
        </div>

        <h1 className="text-5xl md:text-6xl font-extrabold text-white mb-6 leading-tight">
          Học tiếng Việt qua video
          <br />
          <span className="text-amber-300">Sinh động & Hiệu quả</span>
        </h1>

        <p className="text-lg text-emerald-50 max-w-2xl">
          Khám phá thư viện video phong phú với phụ đề đa ngôn ngữ
        </p>
      </div>
    </div>
  );
};