import React from 'react';
import { Search } from 'lucide-react';
import { FILTER_OPTIONS } from '../utils/constants';

export const LessonFilters = ({
  searchTerm,
  selectedNational,
  selectedLevel,
  onSearchChange,
  onNationalChange,
  onLevelChange,
}) => {
  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-12 relative z-20">
      <div className="bg-white rounded-2xl shadow-2xl p-6">
        <div className="flex flex-col md:flex-row gap-4">
          <div className="flex-1 relative">
            <Search
              size={20}
              className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"
            />
            <input
              type="text"
              placeholder="Tìm kiếm bài học..."
              value={searchTerm}
              onChange={(e) => onSearchChange(e.target.value)}
              className="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:border-emerald-500 focus:ring-4 focus:ring-emerald-100 outline-none transition-all"
            />
          </div>

          <div className="flex gap-3">
            <select
              value={selectedNational}
              onChange={(e) => onNationalChange(e.target.value)}
              className="px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-emerald-500 outline-none cursor-pointer transition-all"
            >
              {FILTER_OPTIONS.nationals.map((option) => (
                <option key={option.value} value={option.value}>
                  {option.label}
                </option>
              ))}
            </select>

            <select
              value={selectedLevel}
              onChange={(e) => onLevelChange(e.target.value)}
              className="px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-emerald-500 outline-none cursor-pointer transition-all"
            >
              {FILTER_OPTIONS.levels.map((option) => (
                <option key={option.value} value={option.value}>
                  {option.label}
                </option>
              ))}
            </select>
          </div>
        </div>
      </div>
    </div>
  );
};