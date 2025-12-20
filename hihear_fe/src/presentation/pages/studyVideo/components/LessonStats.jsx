import React from 'react';
import { PlayCircle, Globe, Star, TrendingUp } from 'lucide-react';

const iconMap = {
  PlayCircle,
  Globe,
  Star,
  TrendingUp,
};

export const LessonStats = ({ stats }) => {
  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-12">
        {stats.map((stat, idx) => {
          const Icon = iconMap[stat.icon];
          return (
            <div
              key={idx}
              className="bg-white rounded-2xl p-5 shadow-md hover:shadow-xl transition-all transform hover:-translate-y-1 cursor-pointer"
            >
              <Icon size={24} className={`text-${stat.color}-600 mb-2`} />
              <div className={`text-3xl font-bold text-${stat.color}-600`}>
                {stat.value}
              </div>
              <div className="text-sm text-gray-600">{stat.label}</div>
            </div>
          );
        })}
      </div>
    </div>
  );
};