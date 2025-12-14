import React, { useState, useEffect, useRef } from "react";
import {
  PlayCircle,
  Clock,
  Star,
  BookOpen,
  Globe,
  TrendingUp,
  Filter,
  Search,
  ChevronRight,
  Award,
  Heart,
  AlertCircle,
  Zap,
  Target,
  Sparkles,
  X,
  ArrowLeft,
  Check,
  Volume2,
  Pause,
  Play,
  RotateCcw,
} from "lucide-react";
import { LessonApiService } from "../admin/lessions/services/api/lessonApi";
import { AppAssets } from "../../../Core/constant/AppAssets";
import App from "../Home/HomePage";

const VideoLessonsPage = () => {
  const [lessons, setLessons] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selectedNational, setSelectedNational] = useState("all");
  const [selectedLevel, setSelectedLevel] = useState("all");
  const [searchTerm, setSearchTerm] = useState("");
  const [remainingLessons, setRemainingLessons] = useState();
  const [showLimitModal, setShowLimitModal] = useState(false);
  const [currentLesson, setCurrentLesson] = useState(null);
  const [showTest, setShowTest] = useState(false);
  const [testQuestions, setTestQuestions] = useState([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState(null);
  const [score, setScore] = useState(0);
  const [showResult, setShowResult] = useState(false);

  const videoRef = useRef(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(0);
  const [currentSubtitleVi, setCurrentSubtitleVi] = useState("");
  const [currentSubtitleOther, setCurrentSubtitleOther] = useState("");

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
    checkAndResetDailyLimit();
  }, []);

  const checkAndResetDailyLimit = () => {
    const today = new Date().toDateString();
    const savedData = JSON.parse(localStorage.getItem("dailyLessons") || "{}");

    if (savedData.date !== today) {
      const newData = { date: today, remaining: 5 };
      localStorage.setItem("dailyLessons", JSON.stringify(newData));
      setRemainingLessons(5);
    } else {
      setRemainingLessons(savedData.remaining || 0);
    }
  };

  const generateTestQuestions = (lesson) => {
    const national = lesson.exercises[0]?.national;
    const transcriptions = lesson.lessonVideo.transcriptions;
    const questions = [];

    const shuffled = [...transcriptions]
      .sort(() => 0.5 - Math.random())
      .slice(0, 4);

    shuffled.forEach((trans) => {
      const viWords = trans.vi.split(" ").filter((w) => w.length > 2);
      if (viWords.length === 0) return;

      const blankIndex = Math.floor(Math.random() * viWords.length);
      const correctAnswer = viWords[blankIndex];

      const sentenceWithBlank = viWords
        .map((word, idx) => (idx === blankIndex ? "____" : word))
        .join(" ");

      const otherWords = transcriptions
        .filter((t) => t.vi !== trans.vi)
        .flatMap((t) => t.vi.split(" "))
        .filter((w) => w.length > 2 && w !== correctAnswer);

      const wrongAnswer =
        otherWords[Math.floor(Math.random() * otherWords.length)] || "khác";
      const options = [correctAnswer, wrongAnswer].sort(
        () => 0.5 - Math.random()
      );

      questions.push({
        sentence: sentenceWithBlank,
        englishText:
          national === "UK"
            ? trans.en
            : national === "Korea"
            ? trans.ko
            : trans.vi,
        correctAnswer,
        options,
        originalText: trans.vi,
      });
    });

    return questions;
  };

  const handleStartLesson = (lesson) => {
    if (remainingLessons <= 0) {
      setShowLimitModal(true);
      return;
    }

    const newRemaining = remainingLessons - 1;
    setRemainingLessons(newRemaining);

    const today = new Date().toDateString();
    localStorage.setItem(
      "dailyLessons",
      JSON.stringify({
        date: today,
        remaining: newRemaining,
      })
    );

    setCurrentLesson(lesson);
    setShowTest(false);
    setShowResult(false);
  };

  const handleVideoEnd = () => {
    const questions = generateTestQuestions(currentLesson);
    setTestQuestions(questions);
    setCurrentQuestionIndex(0);
    setScore(0);
    setSelectedAnswer(null);
    setShowTest(true);
  };

  const handleAnswerSelect = (answer) => {
    setSelectedAnswer(answer);
  };

  const handleNextQuestion = () => {
    if (selectedAnswer === testQuestions[currentQuestionIndex].correctAnswer) {
      setScore(score + 1);
    }

    if (currentQuestionIndex < testQuestions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
      setSelectedAnswer(null);
    } else {
      setShowResult(true);
    }
  };

  const handleRetakeTest = () => {
    setCurrentQuestionIndex(0);
    setScore(0);
    setSelectedAnswer(null);
    setShowResult(false);
  };

  const handleBackToLessons = () => {
    setCurrentLesson(null);
    setShowTest(false);
    setShowResult(false);
  };

  useEffect(() => {
    if (videoRef.current) {
      const video = videoRef.current;

      const updateTime = () => {
        setCurrentTime(video.currentTime);

        if (currentLesson?.lessonVideo?.transcriptions) {
          const current = currentLesson.lessonVideo.transcriptions.find(
            (sub) =>
              video.currentTime >= sub.start && video.currentTime <= sub.end
          );

          if (current) {
            const national = currentLesson.exercises[0]?.national;
            setCurrentSubtitleVi(current.vi || "");

            if (national === "UK") {
              setCurrentSubtitleOther(current.en || "");
            } else if (national === "Korea") {
              setCurrentSubtitleOther(current.ko || "");
            } else {
              setCurrentSubtitleOther("");
            }
          } else {
            setCurrentSubtitleVi("");
            setCurrentSubtitleOther("");
          }
        }
      };

      const updateDuration = () => setDuration(video.duration);
      const handleEnded = () => {
        setIsPlaying(false);
        handleVideoEnd();
      };

      video.addEventListener("timeupdate", updateTime);
      video.addEventListener("loadedmetadata", updateDuration);
      video.addEventListener("ended", handleEnded);

      return () => {
        video.removeEventListener("timeupdate", updateTime);
        video.removeEventListener("loadedmetadata", updateDuration);
        video.removeEventListener("ended", handleEnded);
      };
    }
  }, [currentLesson]);

  const togglePlayPause = () => {
    if (videoRef.current) {
      if (isPlaying) {
        videoRef.current.pause();
      } else {
        videoRef.current.play();
      }
      setIsPlaying(!isPlaying);
    }
  };

  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins}:${secs.toString().padStart(2, "0")}`;
  };

  const filteredLessons = lessons.filter((lesson) => {
    const matchesNational =
      selectedNational === "all" ||
      lesson.exercises[0]?.national === selectedNational;
    const matchesLevel =
      selectedLevel === "all" || lesson.level === selectedLevel;
    const matchesSearch = lesson.title
      .toLowerCase()
      .includes(searchTerm.toLowerCase());

    return matchesNational && matchesLevel && matchesSearch;
  });

  const getNationalFlag = (national) => {
    const flags = {
      Vietnam: AppAssets.vietnam,
      Korea: AppAssets.korea,
      UK: AppAssets.uk,
    };
    return flags[national] || "🌍";
  };

  const getLevelColor = (level) => {
    const colors = {
      A1: "from-emerald-500 to-emerald-600",
      A2: "from-blue-500 to-blue-600",
      B1: "from-amber-500 to-amber-600",
      B2: "from-rose-500 to-rose-600",
    };
    return colors[level] || "from-gray-500 to-gray-600";
  };

  const formatDuration = (seconds) => {
    const minutes = Math.floor(seconds / 60);
    return `${minutes} phút`;
  };

  if (currentLesson && !showTest) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-gray-900 to-gray-800">
        <div className="max-w-5xl mx-auto px-4 py-8">
          <button
            onClick={handleBackToLessons}
            className="flex items-center gap-2 text-white mb-6 hover:text-emerald-400 transition-colors"
          >
            <ArrowLeft size={20} />
            <span className="font-medium">Quay lại</span>
          </button>

          <div className="bg-gray-800 rounded-2xl overflow-hidden shadow-2xl">
            <div className="relative bg-black">
              <video
                ref={videoRef}
                src={currentLesson.lessonVideo.videoUrl}
                className="w-full aspect-video"
                onClick={togglePlayPause}
              />

              {!isPlaying && (
                <div className="absolute inset-0 flex items-center justify-center bg-black/30">
                  <button
                    onClick={togglePlayPause}
                    className="w-20 h-20 bg-emerald-600 rounded-full flex items-center justify-center hover:bg-emerald-700 transition-all transform hover:scale-110"
                  >
                    <Play size={40} className="text-white ml-2" fill="white" />
                  </button>
                </div>
              )}

              <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/80 to-transparent p-4">
                <div className="flex items-center gap-4">
                  <button
                    onClick={togglePlayPause}
                    className="text-white hover:text-emerald-400 transition-colors"
                  >
                    {isPlaying ? <Pause size={24} /> : <Play size={24} />}
                  </button>

                  <div className="flex-1">
                    <input
                      type="range"
                      min="0"
                      max={duration}
                      value={currentTime}
                      onChange={(e) => {
                        videoRef.current.currentTime = e.target.value;
                        setCurrentTime(e.target.value);
                      }}
                      className="w-full h-1 bg-gray-600 rounded-lg appearance-none cursor-pointer"
                      style={{
                        background: `linear-gradient(to right, #10b981 0%, #10b981 ${
                          (currentTime / duration) * 100
                        }%, #4b5563 ${
                          (currentTime / duration) * 100
                        }%, #4b5563 100%)`,
                      }}
                    />
                  </div>

                  <span className="text-white text-sm font-medium min-w-[80px] text-right">
                    {formatTime(currentTime)} / {formatTime(duration)}
                  </span>
                </div>
              </div>
            </div>

            <div className="bg-gradient-to-br from-gray-900 to-gray-800 p-6 min-h-[120px] flex items-center justify-center">
              {currentSubtitleVi || currentSubtitleOther ? (
                <div className="w-full max-w-4xl space-y-3">
                  {currentSubtitleVi && (
                    <div className="text-center animate-slideIn">
                      <p
                        className="text-white text-xl font-bold leading-relaxed px-4"
                        style={{
                          textShadow:
                            "0 2px 8px rgba(0,0,0,0.5), 0 0 20px rgba(16,185,129,0.3)",
                        }}
                      >
                        {currentSubtitleVi}
                      </p>
                    </div>
                  )}

                  {currentSubtitleOther && (
                    <div
                      className="text-center animate-slideIn"
                      style={{ animationDelay: "0.1s" }}
                    >
                      <div className="inline-block">
                        <p
                          className="text-transparent bg-clip-text bg-gradient-to-r from-emerald-400 via-teal-400 to-emerald-400 text-lg font-semibold leading-relaxed px-4"
                          style={{
                            textShadow: "0 2px 8px rgba(0,0,0,0.5)",
                            WebkitTextStroke: "0.5px rgba(16,185,129,0.2)",
                          }}
                        >
                          {currentSubtitleOther}
                        </p>
                        <div className="h-0.5 bg-gradient-to-r from-transparent via-emerald-400 to-transparent mt-2"></div>
                      </div>
                    </div>
                  )}
                </div>
              ) : (
                <p className="text-gray-500 text-sm">
                  Phụ đề sẽ hiển thị tại đây...
                </p>
              )}
            </div>

            <div className="p-6 bg-gray-800">
              <div className="flex items-start justify-between mb-4">
                <div>
                  <h2 className="text-2xl font-bold text-white mb-2">
                    {currentLesson.title}
                  </h2>
                  <p className="text-gray-400">{currentLesson.description}</p>
                </div>
              </div>

              <div className="flex items-center gap-4 text-sm text-gray-400">
                <div className="flex items-center gap-1">
                  <Clock size={16} />
                  <span>{formatDuration(currentLesson.durationSeconds)}</span>
                </div>
                <div className="flex items-center gap-1">
                  <Award size={16} className="text-amber-500" />
                  <span>{currentLesson.xpReward} XP</span>
                </div>
                <div
                  className={`px-3 py-1 rounded-full bg-gradient-to-r ${getLevelColor(
                    currentLesson.level
                  )} text-white text-xs font-bold`}
                >
                  {currentLesson.level}
                </div>
              </div>
            </div>
          </div>
        </div>

        <style>{`
          @keyframes slideIn {
            from {
              opacity: 0;
              transform: translateY(10px);
            }
            to {
              opacity: 1;
              transform: translateY(0);
            }
          }
          
          .animate-slideIn {
            animation: slideIn 0.4s cubic-bezier(0.16, 1, 0.3, 1) forwards;
          }
        `}</style>
      </div>
    );
  }

  if (showTest && !showResult) {
    const currentQuestion = testQuestions[currentQuestionIndex];

    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 to-teal-50 py-12 px-4">
        <div className="max-w-3xl mx-auto">
          <div className="bg-white rounded-3xl shadow-2xl p-8">
            <div className="flex items-center justify-between mb-8">
              <h2 className="text-2xl font-bold text-gray-900">
                Bài kiểm tra từ vựng
              </h2>
              <div className="text-emerald-600 font-bold text-lg">
                Câu {currentQuestionIndex + 1}/{testQuestions.length}
              </div>
            </div>

            <div className="mb-8">
              <div className="bg-gradient-to-r from-blue-50 to-indigo-50 p-6 rounded-2xl mb-6 border border-blue-200">
                <p className="text-gray-600 text-sm mb-2 font-medium">
                  {currentLesson.exercises[0]?.national === "UK"
                    ? "English"
                    : currentLesson.exercises[0]?.national === "Korea"
                    ? "Korean"
                    : "Vietnamese"}
                  :
                </p>
                <p className="text-xl text-gray-900 font-medium">
                  {currentQuestion.englishText}
                </p>
              </div>

              <p className="text-gray-700 mb-2 text-sm font-medium">
                Điền vào chỗ trống:
              </p>
              <p className="text-2xl font-bold text-gray-900 mb-8 leading-relaxed">
                {currentQuestion.sentence}
              </p>

              <div className="space-y-4">
                {currentQuestion.options.map((option, idx) => (
                  <button
                    key={idx}
                    onClick={() => handleAnswerSelect(option)}
                    className={`w-full p-5 rounded-2xl border-2 text-left font-medium text-lg transition-all transform hover:scale-105 ${
                      selectedAnswer === option
                        ? "border-emerald-500 bg-emerald-50 text-emerald-900"
                        : "border-gray-200 hover:border-emerald-300 bg-white text-gray-700"
                    }`}
                  >
                    <div className="flex items-center gap-3">
                      <div
                        className={`w-6 h-6 rounded-full border-2 flex items-center justify-center ${
                          selectedAnswer === option
                            ? "border-emerald-500 bg-emerald-500"
                            : "border-gray-300"
                        }`}
                      >
                        {selectedAnswer === option && (
                          <Check size={16} className="text-white" />
                        )}
                      </div>
                      <span>{option}</span>
                    </div>
                  </button>
                ))}
              </div>
            </div>

            <button
              onClick={handleNextQuestion}
              disabled={!selectedAnswer}
              className={`w-full py-4 rounded-2xl font-bold text-lg transition-all transform ${
                selectedAnswer
                  ? "bg-gradient-to-r from-emerald-600 to-emerald-700 text-white hover:from-emerald-700 hover:to-emerald-800 hover:scale-105 active:scale-95"
                  : "bg-gray-200 text-gray-400 cursor-not-allowed"
              }`}
            >
              {currentQuestionIndex < testQuestions.length - 1
                ? "Câu tiếp theo"
                : "Xem kết quả"}
            </button>
          </div>
        </div>
      </div>
    );
  }

  if (showResult) {
    const percentage = (score / testQuestions.length) * 100;

    return (
      <div className="min-h-screen bg-gradient-to-br from-emerald-50 to-teal-50 py-12 px-4">
        <div className="max-w-2xl mx-auto">
          <div className="bg-white rounded-3xl shadow-2xl p-8 text-center">
            <div className="w-32 h-32 mx-auto mb-6 bg-gradient-to-br from-emerald-400 to-emerald-600 rounded-full flex items-center justify-center">
              <Star size={64} className="text-white" fill="white" />
            </div>

            <h2 className="text-3xl font-bold text-gray-900 mb-4">
              Hoàn thành bài học!
            </h2>

            <div className="bg-gradient-to-r from-emerald-50 to-teal-50 p-8 rounded-2xl mb-8">
              <div className="text-6xl font-extrabold text-emerald-600 mb-2">
                {score}/{testQuestions.length}
              </div>
              <p className="text-gray-700 text-lg font-medium">
                Điểm số: {percentage.toFixed(0)}%
              </p>
            </div>

            <div className="flex items-center justify-center gap-2 mb-8">
              <Award size={24} className="text-amber-500" />
              <span className="text-2xl font-bold text-amber-600">
                +{currentLesson.xpReward} XP
              </span>
            </div>

            <div className="flex gap-4">
              <button
                onClick={handleRetakeTest}
                className="flex-1 py-4 rounded-2xl border-2 border-emerald-600 text-emerald-600 font-bold hover:bg-emerald-50 transition-all"
              >
                <RotateCcw size={20} className="inline mr-2" />
                Làm lại
              </button>
              <button
                onClick={handleBackToLessons}
                className="flex-1 py-4 rounded-2xl bg-gradient-to-r from-emerald-600 to-emerald-700 text-white font-bold hover:from-emerald-700 hover:to-emerald-800 transition-all"
              >
                Về trang chủ
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-amber-50 via-yellow-50 to-orange-50">
      {showLimitModal && (
        <div className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-3xl p-8 max-w-md w-full shadow-2xl">
            <button
              onClick={() => setShowLimitModal(false)}
              className="float-right p-2 rounded-full hover:bg-gray-100"
            >
              <X size={24} className="text-gray-500" />
            </button>

            <div className="w-20 h-20 mx-auto mb-6 bg-gradient-to-br from-amber-400 to-orange-500 rounded-full flex items-center justify-center">
              <AlertCircle size={40} className="text-white" />
            </div>

            <h3 className="text-2xl font-bold text-gray-900 mb-4 text-center">
              Đã hết lượt học hôm nay
            </h3>

            <p className="text-gray-600 text-center mb-6">
              Bạn đã sử dụng hết 5 lượt học miễn phí trong ngày. Quay lại vào
              ngày mai!
            </p>

            <button
              onClick={() => setShowLimitModal(false)}
              className="w-full bg-gradient-to-r from-emerald-600 to-emerald-700 text-white py-3 rounded-xl font-semibold hover:from-emerald-700 hover:to-emerald-800"
            >
              Đã hiểu
            </button>
          </div>
        </div>
      )}

      <div className="relative bg-gradient-to-br from-emerald-700 via-emerald-600 to-teal-600 overflow-hidden">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20 relative z-10">
          <div className="flex flex-wrap items-center gap-3 mb-6">
            <div className="inline-flex items-center gap-2 bg-white/20 backdrop-blur-md px-5 py-2 rounded-full border border-white/30">
              <PlayCircle size={20} className="text-amber-200" />
              <span className="text-white font-semibold text-sm">
                BÀI HỌC QUA VIDEO
              </span>
            </div>

            <div
              className={`inline-flex items-center gap-2 backdrop-blur-md px-5 py-2 rounded-full border-2 ${
                remainingLessons > 0
                  ? "bg-emerald-500/20 border-emerald-400/50"
                  : "bg-rose-500/20 border-rose-400/50"
              }`}
            >
              <Heart
                size={18}
                className={
                  remainingLessons > 0 ? "text-emerald-300" : "text-rose-300"
                }
                fill="currentColor"
              />
              <span className="text-white font-bold text-sm">
                {remainingLessons}/5 lượt học
              </span>
            </div>
          </div>

          <h1 className="text-5xl md:text-6xl font-extrabold text-white mb-6 leading-tight">
            Học tiếng Việt qua video
            <br />
            <span className="text-amber-300">Sinh động & Hiệu quả</span>
          </h1>

          <p className="text-lg text-emerald-50 max-w-2xl">
            Khám phá thư viện video phong phú với phụ đề đa ngôn ngữ
          </p>
        </div>
      </div>

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
                onChange={(e) => setSearchTerm(e.target.value)}
                className="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:border-emerald-500 focus:ring-4 focus:ring-emerald-100 outline-none"
              />
            </div>

            <div className="flex gap-3">
              <select
                value={selectedNational}
                onChange={(e) => setSelectedNational(e.target.value)}
                className="px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-emerald-500 outline-none"
              >
                <option value="all">Tất cả ngôn ngữ</option>
                <option value="Vietnam">Tiếng Việt</option>
                <option value="Korea">Tiếng Hàn</option>
                <option value="UK">Tiếng Anh</option>
              </select>

              <select
                value={selectedLevel}
                onChange={(e) => setSelectedLevel(e.target.value)}
                className="px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-emerald-500 outline-none"
              >
                <option value="all">Tất cả trình độ</option>
                <option value="A1">A1</option>
                <option value="A2">A2</option>
                <option value="B1">B1</option>
                <option value="B2">B2</option>
              </select>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-12">
          {[
            {
              icon: PlayCircle,
              label: "Video",
              value: filteredLessons.length,
              color: "emerald",
            },
            { icon: Globe, label: "Ngôn ngữ", value: "3", color: "blue" },
            { icon: Star, label: "Đánh giá", value: "4.9★", color: "amber" },
            {
              icon: TrendingUp,
              label: "Học viên",
              value: "10K+",
              color: "rose",
            },
          ].map((stat, idx) => (
            <div
              key={idx}
              className="bg-white rounded-2xl p-5 shadow-md hover:shadow-xl transition-all"
            >
              <stat.icon size={24} className={`text-${stat.color}-600 mb-2`} />
              <div className={`text-3xl font-bold text-${stat.color}-600`}>
                {stat.value}
              </div>
              <div className="text-sm text-gray-600">{stat.label}</div>
            </div>
          ))}
        </div>

        {loading ? (
          <div className="flex justify-center py-20">
            <div className="w-16 h-16 border-4 border-amber-400 border-t-emerald-600 rounded-full animate-spin" />
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredLessons.map((lesson) => (
              <div
                key={lesson.id}
                className="bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all hover:-translate-y-2 group"
              >
                <div className="relative h-48 overflow-hidden">
                  <img
                    src={AppAssets.hearuHi}
                    alt={lesson.title}
                    className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent" />

                  <div className="absolute inset-0 flex items-center justify-center">
                    <div className="w-16 h-16 bg-white/30 backdrop-blur-md rounded-full flex items-center justify-center group-hover:scale-110 transition-transform">
                      <PlayCircle
                        size={32}
                        className="text-white"
                        fill="white"
                      />
                    </div>
                  </div>

                  <div
                    className={`absolute top-3 left-3 bg-gradient-to-r ${getLevelColor(
                      lesson.level
                    )} text-white px-3 py-1 rounded-full text-xs font-bold`}
                  >
                    {lesson.level}
                  </div>

                  {lesson.exercises && lesson.exercises[0] && (
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
                      onClick={() => handleStartLesson(lesson)}
                      disabled={remainingLessons <= 0}
                      className={`flex items-center gap-1 px-4 py-2 rounded-xl font-semibold text-sm ${
                        remainingLessons <= 0
                          ? "bg-gray-300 text-gray-500 cursor-not-allowed"
                          : "bg-gradient-to-r from-emerald-600 to-emerald-700 text-white hover:from-emerald-700 hover:to-emerald-800"
                      }`}
                    >
                      {remainingLessons <= 0 ? "Hết lượt" : "Học ngay"}
                      <ChevronRight size={16} />
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default VideoLessonsPage;
