export const generateTestQuestions = (lesson) => {
  const national = lesson.exercises[0]?.national;
  const transcriptions = lesson.lessonVideo.transcriptions;
  const questions = [];
  const shuffled = [...transcriptions]
    .sort(() => 0.5 - Math.random())
    .slice(0, 4);

  shuffled.forEach((trans) => {
    const viWords = trans.vi.split(' ').filter((w) => w.length > 2);
    if (viWords.length === 0) return;

    const blankIndex = Math.floor(Math.random() * viWords.length);
    const correctAnswer = viWords[blankIndex];

    const sentenceWithBlank = viWords
      .map((word, idx) => (idx === blankIndex ? '____' : word))
      .join(' ');

    const otherWords = transcriptions
      .filter((t) => t.vi !== trans.vi)
      .flatMap((t) => t.vi.split(' '))
      .filter((w) => w.length > 2 && w !== correctAnswer);

    const wrongAnswer =
      otherWords[Math.floor(Math.random() * otherWords.length)] || 'khác';
    
    const options = [correctAnswer, wrongAnswer].sort(
      () => 0.5 - Math.random()
    );

    questions.push({
      sentence: sentenceWithBlank,
      englishText:
        national === 'UK'
          ? trans.en
          : national === 'Korea'
          ? trans.ko
          : trans.vi,
      correctAnswer,
      options,
      originalText: trans.vi,
    });
  });

  return questions;
};