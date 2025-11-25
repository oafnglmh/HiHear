import React, { useState, useEffect, useCallback, useMemo, memo } from "react";
import { X, Save, Plus } from "lucide-react";
import { useLessonForm } from "../hooks/useLessonForm";
import QuestionForm from "./QuestionForm";
import GrammarForm from "./GrammarForm";
import PronunciationForm from "./PronunciationForm";
import ListeningForm from "./ListeningForm";
import VideoForm from "./VideoForm";
import { saveLesson, editLesson } from "../services/lessonService";
import toast from "react-hot-toast";
import "../css/Lessons.css";

// ============= CONSTANTS =============
const CATEGORIES = {
  VOCABULARY: "Từ vựng",
  GRAMMAR: "Ngữ pháp",
  PRONUNCIATION: "Phát Âm",
  LISTENING: "Nghe hiểu",
  VIDEO: "Video",
};

const LEVELS = ["A1", "A2", "B1", "B2", "C1", "C2"];

const LANGUAGES = [
  { code: "Vietnam", name: "Tiếng Việt", langCode: "vi" },
  { code: "Korea", name: "Tiếng Hàn", langCode: "ko" },
  { code: "UK", name: "Tiếng Anh", langCode: "en" },
];

// ============= UTILITIES =============
const translateText = async (text, targetLangCode) => {
  if (!text?.trim()) return text;

  try {
    const encodedText = encodeURIComponent(text);
    const url = `https://api.mymemory.translated.net/get?q=${encodedText}&langpair=vi|${targetLangCode}`;
    const response = await fetch(url);
    const data = await response.json();

    return data.responseStatus === 200
      ? data.responseData.translatedText
      : text;
  } catch (error) {
    console.error("Translation error:", error);
    return text;
  }
};

const batchTranslate = async (texts, targetLangCode) => {
  return Promise.all(texts.map((text) => translateText(text, targetLangCode)));
};

// ============= CUSTOM HOOKS =============
const useTranslation = () => {
  const [isTranslating, setIsTranslating] = useState(false);

  const translateVocabulary = useCallback(async (questions, langCode) => {
    const allOptions = questions.flatMap((q) => [q.optionA, q.optionB]);
    const translated = await batchTranslate(allOptions, langCode);

    return questions.map((q, idx) => ({
      ...q,
      optionA: translated[idx * 2],
      optionB: translated[idx * 2 + 1],
    }));
  }, []);

  const translateGrammar = useCallback(async (examples, langCode) => {
    const meanings = examples.map((ex) => ex.meaning);
    const translated = await batchTranslate(meanings, langCode);

    return examples.map((ex, idx) => ({
      ...ex,
      meaning: translated[idx],
    }));
  }, []);

  return {
    isTranslating,
    setIsTranslating,
    translateVocabulary,
    translateGrammar,
  };
};

// ============= MEMOIZED COMPONENTS =============
const VocabularyContent = memo(
  ({
    questions,
    handleChangeQuestion,
    handleDeleteQuestion,
    handleAddQuestion,
  }) => (
    <div className="category-content-wrapper">
      {questions.map((q) => (
        <QuestionForm
          key={q.id}
          q={q}
          onChange={handleChangeQuestion}
          onDelete={handleDeleteQuestion}
        />
      ))}
      <button
        type="button"
        className="add-question-btn"
        onClick={handleAddQuestion}
      >
        <Plus size={20} />
        Thêm câu hỏi
      </button>
    </div>
  )
);

const GrammarContent = memo(
  ({ grammarRule, setGrammarRule, grammarExamples, setGrammarExamples }) => (
    <div className="category-content-wrapper">
      <GrammarForm
        grammarRule={grammarRule}
        setGrammarRule={setGrammarRule}
        examples={grammarExamples}
        setExamples={setGrammarExamples}
      />
    </div>
  )
);

const PronunciationContent = memo(
  ({
    pronunciationOrder,
    setPronunciationOrder,
    pronunciationExamples,
    setPronunciationExamples,
  }) => (
    <div className="category-content-wrapper">
      <PronunciationForm
        order={pronunciationOrder}
        setOrder={setPronunciationOrder}
        examples={pronunciationExamples}
        setExamples={setPronunciationExamples}
      />
    </div>
  )
);

const ListeningContent = memo(({ listenings, setListenings }) => (
  <div className="category-content-wrapper">
    <ListeningForm listenings={listenings} setListenings={setListenings} />
  </div>
));

const VideoContent = memo(({ videoData, setVideoData }) => (
  <div className="category-content-wrapper">
    <VideoForm videoData={videoData} setVideoData={setVideoData} />
  </div>
));

// ============= MAIN COMPONENT =============
export default function AddLesson({
  onClose,
  onSave,
  lessonOptions = [],
  editingLesson = null,
}) {
  const {
    id,
    setId,
    title,
    setTitle,
    category,
    setCategory,
    level,
    setLevel,
    preview,
    handleImageChange,
    questions,
    setQuestions,
    handleAddQuestion,
    handleDeleteQuestion,
    handleChangeQuestion,
    grammarExamples,
    setGrammarExamples,
    grammarRule,
    setGrammarRule,
    pronunciationExamples,
    setPronunciationExamples,
    pronunciationOrder,
    setPronunciationOrder,
  } = useLessonForm();

  const [type, setType] = useState("Từ vựng");
  const [description, setDescription] = useState("");
  const [prerequisiteLesson, setPrerequisiteLesson] = useState(null);
  const [listenings, setListenings] = useState([]);
  const [videoData, setVideoData] = useState(null);

  const {
    isTranslating,
    setIsTranslating,
    translateVocabulary,
    translateGrammar,
  } = useTranslation();

  // ============= LOAD EDITING LESSON =============
  useEffect(() => {
    if (!editingLesson) return;

    setId(editingLesson.id || "");
    setTitle(editingLesson.title || "");
    setCategory(editingLesson.category || "");
    setLevel(editingLesson.level || "A1");
    setDescription(editingLesson.description || "");
    setPrerequisiteLesson(editingLesson.prerequisiteLesson || null);
    setType(editingLesson.type || "Từ vựng");
    setQuestions(editingLesson.questions || []);
    setGrammarRule(editingLesson.grammarRule || "");
    setGrammarExamples(editingLesson.grammarExamples || []);
    setPronunciationExamples(editingLesson.pronunciationExamples || []);
    setPronunciationOrder(editingLesson.pronunciationOrder || 1);
    setListenings(editingLesson.listenings || []);
    setVideoData(editingLesson.videoData || null);
  }, [editingLesson]);

  // ============= BUILD EXERCISES =============
  const buildExercises = useCallback(
    (langCode, translatedData = null) => {
      const baseExercise = {
        type: "mcq",
        points: 0,
        national: langCode,
        vocabularies: [],
        grammars: [],
        listenings: [],
      };

      switch (category) {
        case CATEGORIES.VOCABULARY: {
          const questionsToUse = translatedData || questions;
          return [
            {
              ...baseExercise,
              points: 5,
              vocabularies: questionsToUse.map((q) => ({
                question: q.text,
                choices: [q.optionA, q.optionB],
                correctAnswer: q.correct === "A" ? q.optionA : q.optionB,
              })),
            },
          ];
        }

        case CATEGORIES.GRAMMAR: {
          const examplesToUse = translatedData || grammarExamples;
          return [
            {
              ...baseExercise,
              grammars: examplesToUse.map((ex) => ({
                grammarRule: ex.grammarRule,
                example: ex.example,
                meaning: ex.meaning,
              })),
            },
          ];
        }

        case CATEGORIES.LISTENING: {
          return [
            {
              ...baseExercise,
              listenings: listenings.map((l) => ({
                transcript: l.transcript,
                choices: l.choices,
                correctAnswer: l.correctAnswer,
                mediaId: null,
              })),
            },
          ];
        }

        case CATEGORIES.PRONUNCIATION: {
          return [
            {
              type: "listening",
              points: 0,
              national: langCode,
              vocabularies: [],
              grammars: [],
              listenings: pronunciationExamples.map((ex) => ({
                example: ex.text,
                meaning: "",
              })),
            },
          ];
        }

        case CATEGORIES.VIDEO: {
          if (!videoData?.transcriptions) return [];

          return [
            {
              type: "mcq",
              points: 0,
              national: langCode,
              vocabularies: [],
              grammars: [],
              listenings: [],
              video: [
                {
                  linkVideo: videoData.fileName,
                  transl: videoData.transcriptions.map((item) => ({
                    vi: item.vi,
                    en: item.en,
                    ko: item.ko,
                  })),
                },
              ],
            },
          ];
        }

        default:
          return [];
      }
    },
    [
      category,
      questions,
      grammarExamples,
      listenings,
      pronunciationExamples,
      videoData,
      description,
    ]
  );

  // ============= GET TRANSLATED DATA =============
  const getTranslatedData = useCallback(
    async (langCode) => {
      if (langCode === "vi") return null;

      switch (category) {
        case CATEGORIES.VOCABULARY:
          return await translateVocabulary(questions, langCode);

        case CATEGORIES.GRAMMAR:
          return await translateGrammar(grammarExamples, langCode);

        case CATEGORIES.LISTENING:
          return listenings.map((l) => ({
            transcript: l.transcript || "",
            choices: l.choices || [],
            correctAnswer: l.correctAnswer || "",
          }));

        case CATEGORIES.VIDEO:
          // Video already has all language transcriptions
          return null;

        default:
          return null;
      }
    },
    [
      category,
      questions,
      grammarExamples,
      listenings,
      translateVocabulary,
      translateGrammar,
    ]
  );

  // ============= CREATE LESSON PAYLOAD =============
  const createLessonPayload = useCallback(
    (translatedTitle, langCode, translatedData) => ({
      title: translatedTitle,
      description,
      category,
      level,
      prerequisiteLesson,
      mediaId: preview || null,
      exercises: buildExercises(langCode, translatedData),
    }),
    [description, category, level, prerequisiteLesson, preview, buildExercises]
  );

  // ============= HANDLE UPDATE =============
  const handleUpdate = useCallback(async () => {
    const payload = createLessonPayload(title, "Vietnam", null);

    try {
      const result = await editLesson(payload, id);
      toast.success("Cập nhật thành công!");
      onSave(result.data);
      onClose();
    } catch (err) {
      toast.error("Cập nhật thất bại!");
      console.error(err);
    }
  }, [createLessonPayload, title, id, onSave, onClose]);

  // ============= HANDLE CREATE =============
  const handleCreate = useCallback(async () => {
    setIsTranslating(true);
    const toastId = toast.loading("Đang tạo bài học đa ngôn ngữ...");

    try {
      await Promise.all(
        LANGUAGES.map(async (lang) => {
          const translatedTitle =
            lang.langCode === "vi"
              ? title
              : await translateText(title, lang.langCode);

          const translatedData = await getTranslatedData(lang.langCode);
          const payload = createLessonPayload(
            translatedTitle,
            lang.code,
            translatedData
          );

          console.log(`Payload for ${lang.name}:`, payload);
          return saveLesson(payload);
        })
      );

      toast.success("Tạo thành công 3 phiên bản ngôn ngữ!", { id: toastId });
      onSave({ success: true });
      onClose();
    } catch (err) {
      toast.error("Có lỗi xảy ra khi tạo bài học!", { id: toastId });
      console.error(err);
    } finally {
      setIsTranslating(false);
    }
  }, [
    title,
    getTranslatedData,
    createLessonPayload,
    onSave,
    onClose,
    setIsTranslating,
  ]);

  // ============= HANDLE SUBMIT =============
  const handleSubmit = useCallback(
    async (e) => {
      e.preventDefault();
      if (editingLesson) {
        await handleUpdate();
      } else {
        await handleCreate();
      }
    },
    [editingLesson, handleUpdate, handleCreate]
  );

  // ============= MEMOIZED HANDLERS =============
  const handleTitleChange = useCallback(
    (e) => {
      setTitle(e.target.value);
    },
    [setTitle]
  );

  const handleDescriptionChange = useCallback((e) => {
    setDescription(e.target.value);
  }, []);

  const handleTypeChange = useCallback((e) => {
    setType(e.target.value);
  }, []);

  const handleLevelChange = useCallback(
    (e) => {
      setLevel(e.target.value);
    },
    [setLevel]
  );

  const handlePrerequisiteChange = useCallback((e) => {
    setPrerequisiteLesson(e.target.value || null);
  }, []);

  const handleCategoryChange = useCallback(
    (e) => {
      setCategory(e.target.value);
    },
    [setCategory]
  );

  // ============= RENDER CATEGORY CONTENT =============
  const renderCategoryContent = useMemo(() => {
    switch (category) {
      case CATEGORIES.VOCABULARY:
        return (
          <VocabularyContent
            questions={questions}
            handleChangeQuestion={handleChangeQuestion}
            handleDeleteQuestion={handleDeleteQuestion}
            handleAddQuestion={handleAddQuestion}
          />
        );

      case CATEGORIES.GRAMMAR:
        return (
          <GrammarContent
            grammarRule={grammarRule}
            setGrammarRule={setGrammarRule}
            grammarExamples={grammarExamples}
            setGrammarExamples={setGrammarExamples}
          />
        );

      case CATEGORIES.PRONUNCIATION:
        return (
          <PronunciationContent
            pronunciationOrder={pronunciationOrder}
            setPronunciationOrder={setPronunciationOrder}
            pronunciationExamples={pronunciationExamples}
            setPronunciationExamples={setPronunciationExamples}
          />
        );

      case CATEGORIES.LISTENING:
        return (
          <ListeningContent
            listenings={listenings}
            setListenings={setListenings}
          />
        );

      case CATEGORIES.VIDEO:
        return (
          <VideoContent videoData={videoData} setVideoData={setVideoData} />
        );

      default:
        return null;
    }
  }, [
    category,
    questions,
    description,
    grammarExamples,
    pronunciationOrder,
    pronunciationExamples,
    listenings,
    videoData,
    handleChangeQuestion,
    handleDeleteQuestion,
    handleAddQuestion,
    setGrammarExamples,
    setPronunciationOrder,
    setPronunciationExamples,
    setListenings,
    setVideoData,
  ]);

  // ============= CATEGORY TITLE =============
  const categoryTitle = useMemo(() => {
    switch (category) {
      case CATEGORIES.VOCABULARY:
        return "📝 Nội dung từ vựng";
      case CATEGORIES.GRAMMAR:
        return "📚 Nội dung ngữ pháp";
      case CATEGORIES.PRONUNCIATION:
        return "🗣️ Nội dung phát âm";
      case CATEGORIES.LISTENING:
        return "👂 Nội dung nghe hiểu";
      case CATEGORIES.VIDEO:
        return "🎥 Nội dung video";
      default:
        return "";
    }
  }, [category]);

  // ============= RENDER =============
  return (
    <div className="add-lesson-overlay">
      <div className="add-lesson-modal">
        <div className="modal-header">
          <h2>{editingLesson ? "Cập nhật bài học" : "Thêm bài học mới"}</h2>
          <button className="close-btn" onClick={onClose} type="button">
            <X size={24} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="lesson-form">
          <div className="form-section">
            <label>Tên bài học:</label>
            <input
              type="text"
              value={title}
              onChange={handleTitleChange}
              required
              placeholder="Nhập tên bài học..."
            />
          </div>

          <div className="form-section">
            <label>Mô tả:</label>
            <textarea
              value={description}
              onChange={handleDescriptionChange}
              rows={3}
              placeholder="Nhập mô tả bài học..."
            />
          </div>

          <div className="form-row">
            <div className="form-section">
              <label>Phân loại chi tiết:</label>
              <input
                type="text"
                value={type}
                onChange={handleTypeChange}
                required
                placeholder="Ví dụ: Giao tiếp cơ bản"
              />
            </div>

            <div className="form-section">
              <label>Độ khó:</label>
              <select value={level} onChange={handleLevelChange}>
                {LEVELS.map((lvl) => (
                  <option key={lvl} value={lvl}>
                    {lvl}
                  </option>
                ))}
              </select>
            </div>
          </div>

          <div className="form-row">
            <div className="form-section">
              <label>Bài học yêu cầu trước:</label>
              <select
                value={prerequisiteLesson || ""}
                onChange={handlePrerequisiteChange}
              >
                <option value="">Không</option>
                {lessonOptions.map((l) => (
                  <option key={l.id} value={l.id}>
                    {l.title}
                  </option>
                ))}
              </select>
            </div>

            <div className="form-section">
              <label>Loại bài học:</label>
              <select value={category} onChange={handleCategoryChange}>
                <option value="">Chọn Loại</option>
                {Object.values(CATEGORIES).map((cat) => (
                  <option key={cat} value={cat}>
                    {cat}
                  </option>
                ))}
              </select>
            </div>
          </div>

          {category && (
            <div className="category-section">
              <h4 className="section-title">{categoryTitle}</h4>
              {renderCategoryContent}
            </div>
          )}

          <button type="submit" className="save-btn" disabled={isTranslating}>
            <Save size={18} />
            {isTranslating
              ? "Đang xử lý..."
              : editingLesson
              ? "Cập nhật"
              : "Thêm bài học (3 ngôn ngữ)"}
          </button>
        </form>
      </div>
    </div>
  );
}
