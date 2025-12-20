import { LEVEL_COLORS, NATIONAL_FLAGS } from './constants';

export const getLevelColor = (level) => {
  return LEVEL_COLORS[level] || 'from-gray-500 to-gray-600';
};

export const getNationalFlag = (national) => {
  return NATIONAL_FLAGS[national] || '🌍';
};

export const filterLessons = (lessons, { national, level, searchTerm }) => {
  if (!Array.isArray(lessons)) return [];
  
  return lessons.filter((lesson) => {
    const matchesNational =
      national === 'all' ||
      lesson.exercises?.[0]?.national === national;
    
    const matchesLevel =
      level === 'all' ||
      lesson.level === level;
    
    const matchesSearch =
      !searchTerm ||
      lesson.title?.toLowerCase().includes(searchTerm.toLowerCase());

    return matchesNational && matchesLevel && matchesSearch;
  });
};

export const getLessonNational = (lesson) => {
  return lesson?.exercises?.[0]?.national || 'Vietnam';
};