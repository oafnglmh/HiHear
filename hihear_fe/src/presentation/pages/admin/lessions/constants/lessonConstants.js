export const LESSON_CATEGORIES = {
  VOCABULARY: "Từ vựng",
  GRAMMAR: "Ngữ pháp",
  PRONUNCIATION: "Phát Âm",
  LISTENING: "Nghe hiểu",
  VIDEO: "Video",
};

export const LESSON_LEVELS = ["A1", "A2", "B1", "B2", "C1", "C2"];

export const LANGUAGES = [
  { code: "Vietnam", name: "Tiếng Việt", langCode: "vi" },
  { code: "Korea", name: "Tiếng Hàn", langCode: "ko" },
  { code: "UK", name: "Tiếng Anh", langCode: "en" },
];

export const DEFAULT_VOCABULARY_QUESTION = {
  id: null,
  text: "",
  optionA: "",
  optionB: "",
  correct: "A",
};

export const DEFAULT_GRAMMAR_EXAMPLE = {
  id: null,
  grammarRule: "",
  example: "",
  meaning: "",
};

export const DEFAULT_PRONUNCIATION_EXAMPLE = {
  id: null,
  text: "",
};

export const DEFAULT_LISTENING_ITEM = {
  transcript: "",
  choices: ["", "", ""],
  correctAnswer: "",
};