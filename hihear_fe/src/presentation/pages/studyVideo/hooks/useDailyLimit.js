import { useState, useEffect } from 'react';
import { DAILY_LESSON_LIMIT, LOCAL_STORAGE_KEYS } from '../utils/constants';

export const useDailyLimit = () => {
  const [remainingLessons, setRemainingLessons] = useState(DAILY_LESSON_LIMIT);
  const [showLimitModal, setShowLimitModal] = useState(false);

  useEffect(() => {
    checkAndResetDailyLimit();
  }, []);

  const checkAndResetDailyLimit = () => {
    const today = new Date().toDateString();
    const savedData = JSON.parse(
      localStorage.getItem(LOCAL_STORAGE_KEYS.DAILY_LESSONS) || '{}'
    );

    if (savedData.date !== today) {
      const newData = { date: today, remaining: DAILY_LESSON_LIMIT };
      localStorage.setItem(
        LOCAL_STORAGE_KEYS.DAILY_LESSONS,
        JSON.stringify(newData)
      );
      setRemainingLessons(DAILY_LESSON_LIMIT);
    } else {
      setRemainingLessons(
        typeof savedData.remaining === 'number'
          ? savedData.remaining
          : DAILY_LESSON_LIMIT
      );
    }
  };

  const consumeLesson = () => {
    if (remainingLessons <= 0) {
      setShowLimitModal(true);
      return false;
    }

    setRemainingLessons(prev => {
      const updated = prev - 1;
      const today = new Date().toDateString();

      localStorage.setItem(
        LOCAL_STORAGE_KEYS.DAILY_LESSONS,
        JSON.stringify({ date: today, remaining: updated })
      );

      return updated;
    });

    return true;
  };
  const addLessons = (count) => {
    setRemainingLessons(prev => {
      const updated = prev + count;
      const today = new Date().toDateString();

      localStorage.setItem(
        LOCAL_STORAGE_KEYS.DAILY_LESSONS,
        JSON.stringify({ date: today, remaining: updated })
      );

      return updated;
    });
  };

  return {
    remainingLessons,
    showLimitModal,
    setShowLimitModal,
    consumeLesson,
    addLessons,
  };
};
