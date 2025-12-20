import { useState } from 'react';

export const useQuiz = () => {
  const [showTest, setShowTest] = useState(false);
  const [testQuestions, setTestQuestions] = useState([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState(null);
  const [score, setScore] = useState(0);
  const [showResult, setShowResult] = useState(false);

  const startQuiz = (questions) => {
    setTestQuestions(questions);
    setCurrentQuestionIndex(0);
    setScore(0);
    setSelectedAnswer(null);
    setShowTest(true);
    setShowResult(false);
  };

  const selectAnswer = (answer) => {
    setSelectedAnswer(answer);
  };

  const nextQuestion = () => {
    const currentQuestion = testQuestions[currentQuestionIndex];
    
    if (selectedAnswer === currentQuestion.correctAnswer) {
      setScore(score + 1);
    }

    if (currentQuestionIndex < testQuestions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
      setSelectedAnswer(null);
    } else {
      setShowResult(true);
    }
  };

  const retakeQuiz = () => {
    setCurrentQuestionIndex(0);
    setScore(0);
    setSelectedAnswer(null);
    setShowResult(false);
  };

  const resetQuiz = () => {
    setShowTest(false);
    setShowResult(false);
    setTestQuestions([]);
    setCurrentQuestionIndex(0);
    setSelectedAnswer(null);
    setScore(0);
  };

  return {
    showTest,
    testQuestions,
    currentQuestionIndex,
    selectedAnswer,
    score,
    showResult,
    startQuiz,
    selectAnswer,
    nextQuestion,
    retakeQuiz,
    resetQuiz,
  };
};