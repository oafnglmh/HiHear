import React from "react";
import { PlayCircle, Clock, Award, ChevronRight } from "lucide-react";
import { AppAssets } from "../../../../Core/constant/AppAssets";
import { getLevelColor, getNationalFlag } from "../utils/lessonHelpers";
import { formatDuration } from "../utils/timeFormatter";

export const LessonCard = ({ lesson, onStart, canStart }) => {
  return (
    <div className="bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all hover:-translate-y-2 group">
      <div className="relative h-48 overflow-hidden">
        <img
          src={AppAssets.hearuHi}
          alt={lesson.title}
          className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent" />

        <div className="absolute inset-0 flex items-center justify-center">
          <div className="w-16 h-16 bg-white/30 backdrop-blur-md rounded-full flex items-center justify-center group-hover:scale-110 transition-transform">
            <PlayCircle size={32} className="text-white" fill="white" />
          </div>
        </div>

        <div
          className={`absolute top-3 left-3 bg-gradient-to-r ${getLevelColor(
            lesson.level
          )} text-white px-3 py-1 rounded-full text-xs font-bold`}
        >
          {lesson.level}
        </div>

        {lesson.exercises?.[0] && (
          <img
            src={getNationalFlag(lesson.exercises[0].national)}
            alt={lesson.exercises[0].national}
            className="absolute top-3 right-3 object-cover"
          />
        )}
      </div>

      <div className="p-6">
        <h3 className="text-xl font-bold text-gray-900 mb-2 line-clamp-2">
          {lesson.title}
        </h3>
        <p className="text-gray-600 text-sm mb-4 line-clamp-2">
          {lesson.description}
        </p>

        <div className="flex items-center justify-between pt-4 border-t">
          <div className="flex gap-4 text-sm text-gray-500">
            <div className="flex items-center gap-1">
              <Clock size={16} />
              <span>{formatDuration(lesson.durationSeconds)}</span>
            </div>
            <div className="flex items-center gap-1">
              <Award size={16} className="text-amber-500" />
              <span>{lesson.xpReward} XP</span>
            </div>
          </div>

          <button
            onClick={() => onStart(lesson)}
            className={`flex items-center gap-1 px-4 py-2 rounded-xl font-semibold text-sm transition-all ${
              !canStart
                ? "bg-gray-300 text-gray-600"
                : "bg-gradient-to-r from-emerald-600 to-emerald-700 text-white hover:from-emerald-700 hover:to-emerald-800"
            }`}
          >
            {!canStart ? "Hết lượt" : "Học ngay"}
            <ChevronRight size={16} />
          </button>
        </div>
      </div>
    </div>
  );
};
