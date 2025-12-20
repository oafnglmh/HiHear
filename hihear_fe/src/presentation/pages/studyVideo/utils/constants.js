import { AppAssets } from '../../../../Core/constant/AppAssets';

export const DAILY_LESSON_LIMIT = 5;

export const LEVEL_COLORS = {
  A1: 'from-emerald-500 to-emerald-600',
  A2: 'from-blue-500 to-blue-600',
  B1: 'from-amber-500 to-amber-600',
  B2: 'from-rose-500 to-rose-600',
};

export const NATIONAL_FLAGS = {
  Vietnam: AppAssets.vietnam,
  Korea: AppAssets.korea,
  UK: AppAssets.uk,
};

export const FILTER_OPTIONS = {
  nationals: [
    { value: 'all', label: 'Tất cả ngôn ngữ' },
    { value: 'Vietnam', label: 'Tiếng Việt' },
    { value: 'Korea', label: 'Tiếng Hàn' },
    { value: 'UK', label: 'Tiếng Anh' },
  ],
  levels: [
    { value: 'all', label: 'Tất cả trình độ' },
    { value: 'A1', label: 'A1' },
    { value: 'A2', label: 'A2' },
    { value: 'B1', label: 'B1' },
    { value: 'B2', label: 'B2' },
  ],
};

export const STATS_CONFIG = [
  { icon: 'PlayCircle', label: 'Video', valueKey: 'lessonsCount', color: 'emerald' },
  { icon: 'Globe', label: 'Ngôn ngữ', value: '3', color: 'blue' },
  { icon: 'Star', label: 'Đánh giá', value: '4.9★', color: 'amber' },
  { icon: 'TrendingUp', label: 'Học viên', value: '10K+', color: 'rose' },
]; 

export const LOCAL_STORAGE_KEYS = {
  DAILY_LESSONS: 'dailyLessons',
};

export const LANGUAGE_LABELS = {
  UK: 'English',
  Korea: 'Korean',
  Vietnam: 'Vietnamese',
};