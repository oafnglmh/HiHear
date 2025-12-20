import React, { useState, useEffect } from "react";
import { LessonApiService } from "../admin/lessions/services/api/lessonApi";
import { VideoPlayer } from "./components/VideoPlayer";
import { QuizQuestion } from "./components/QuizQuestion";
import { QuizResult } from "./components/QuizResult";
import { LessonCard } from "./components/LessonCard";
import { LessonFilters } from "./components/LessonFilters";
import { LessonStats } from "./components/LessonStats";
import { PageHeader } from "./components/PageHeader";
import { LimitModal } from "./components/LimitModal";
import { GameContainer } from "./components/GameContainer";
import { useDailyLimit } from "./hooks/useDailyLimit";
import { useQuiz } from "./hooks/useQuiz";
import { useGame } from "./hooks/useGame";
import { generateTestQuestions } from "./services/quizService";
import { filterLessons } from "./utils/lessonHelpers";
import {
  STATS_CONFIG,
  LOCAL_STORAGE_KEYS,
  DAILY_LESSON_LIMIT,
} from "./utils/constants";
import { GAME_CONFIG } from "./utils/gameConstants";

const VideoLessonsPage = () => {
  const [lessons, setLessons] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selectedNational, setSelectedNational] = useState("all");
  const [selectedLevel, setSelectedLevel] = useState("all");
  const [searchTerm, setSearchTerm] = useState("");
  const [currentLesson, setCurrentLesson] = useState(null);

  const { remainingLessons, showLimitModal, setShowLimitModal, consumeLesson,addLessons } =
    useDailyLimit();

  const {
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
  } = useQuiz();

  const {
    canPlayToday,
    currentGate,
    completedGates,
    gameState,
    showGame,
    startGame,
    openGateChallenge,
    completeChallengeSuccess,
    completeChallengeFailed,
    closeGame,
  } = useGame();

  useEffect(() => {
    const fetchLessons = async () => {
      try {
        setLoading(true);
        const data = await LessonApiService.getvideo();
        console.log("Fetched video lessons:", data);
        setLessons(data);
      } catch (error) {
        console.error("Fetch video lessons error:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchLessons();
  }, []);

  const handleStartLesson = (lesson) => {
    if (!consumeLesson()) return;
    setCurrentLesson(lesson);
    resetQuiz();
  };

  const handleVideoEnd = () => {
    const questions = generateTestQuestions(currentLesson);
    startQuiz(questions);
  };

  const handleBackToLessons = () => {
    setCurrentLesson(null);
    resetQuiz();
  };

  const handleStartGame = () => {
    const success = startGame();
    if (!success) {
      alert("Bạn đã chơi game hôm nay rồi!");
    }
  };

  const handleGameComplete = () => {
    addLessons(GAME_CONFIG.REWARD_LESSONS);
    closeGame();
    setShowLimitModal(false);
  };

  const filteredLessons = filterLessons(lessons, {
    national: selectedNational,
    level: selectedLevel,
    searchTerm,
  });

  const stats = STATS_CONFIG.map((stat) => ({
    ...stat,
    value:
      stat.valueKey === "lessonsCount" ? filteredLessons.length : stat.value,
  }));

  if (showGame) {
    return (
      <GameContainer
        gameState={gameState}
        completedGates={completedGates}
        currentGate={currentGate}
        onGateReached={openGateChallenge}
        onChallengeSuccess={completeChallengeSuccess}
        onChallengeFailed={completeChallengeFailed}
        onGameComplete={handleGameComplete}
        onClose={closeGame}
      />
    );
  }

  if (currentLesson && !showTest) {
    return (
      <VideoPlayer
        lesson={currentLesson}
        onBack={handleBackToLessons}
        onVideoEnd={handleVideoEnd}
      />
    );
  }

  if (showTest && !showResult) {
    return (
      <QuizQuestion
        question={testQuestions[currentQuestionIndex]}
        currentIndex={currentQuestionIndex}
        totalQuestions={testQuestions.length}
        selectedAnswer={selectedAnswer}
        onSelectAnswer={selectAnswer}
        onNext={nextQuestion}
        national={currentLesson.exercises[0]?.national}
      />
    );
  }

  if (showResult) {
    return (
      <QuizResult
        score={score}
        totalQuestions={testQuestions.length}
        xpReward={currentLesson.xpReward}
        onRetake={retakeQuiz}
        onBackToLessons={handleBackToLessons}
      />
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-amber-50 via-yellow-50 to-orange-50">
      <LimitModal
        isOpen={showLimitModal}
        onClose={() => setShowLimitModal(false)}
        canPlayGame={canPlayToday}
        onStartGame={handleStartGame}
      />

      <PageHeader remainingLessons={remainingLessons} />

      <LessonFilters
        searchTerm={searchTerm}
        selectedNational={selectedNational}
        selectedLevel={selectedLevel}
        onSearchChange={setSearchTerm}
        onNationalChange={setSelectedNational}
        onLevelChange={setSelectedLevel}
      />

      <LessonStats stats={stats} />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pb-12">
        {loading ? (
          <div className="flex justify-center py-20">
            <div className="w-16 h-16 border-4 border-amber-400 border-t-emerald-600 rounded-full animate-spin" />
          </div>
        ) : filteredLessons.length === 0 ? (
          <div className="text-center py-20">
            <p className="text-gray-500 text-lg">
              Không tìm thấy bài học nào phù hợp
            </p>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredLessons.map((lesson) => (
              <LessonCard
                key={lesson.id}
                lesson={lesson}
                onStart={handleStartLesson}
                canStart={remainingLessons > 0}
              />
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default VideoLessonsPage;
