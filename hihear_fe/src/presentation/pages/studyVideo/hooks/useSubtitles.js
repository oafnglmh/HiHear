import { useState, useEffect } from 'react';

export const useSubtitles = (lesson, currentTime) => {
  const [currentSubtitleVi, setCurrentSubtitleVi] = useState('');
  const [currentSubtitleOther, setCurrentSubtitleOther] = useState('');

  useEffect(() => {
    if (!lesson?.lessonVideo?.transcriptions) {
      setCurrentSubtitleVi('');
      setCurrentSubtitleOther('');
      return;
    }

    const current = lesson.lessonVideo.transcriptions.find(
      (sub) => currentTime >= sub.start && currentTime <= sub.end
    );

    if (current) {
      const national = lesson.exercises[0]?.national;
      setCurrentSubtitleVi(current.vi || '');

      if (national === 'UK') {
        setCurrentSubtitleOther(current.en || '');
      } else if (national === 'Korea') {
        setCurrentSubtitleOther(current.ko || '');
      } else {
        setCurrentSubtitleOther('');
      }
    } else {
      setCurrentSubtitleVi('');
      setCurrentSubtitleOther('');
    }
  }, [lesson, currentTime]);

  return {
    currentSubtitleVi,
    currentSubtitleOther,
  };
};