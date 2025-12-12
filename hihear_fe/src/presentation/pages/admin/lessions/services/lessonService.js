import { LESSON_CATEGORIES } from "../constants/lessonConstants";

export class LessonService {
  static buildExercises(category, data, langCode) {
    const baseExercise = {
      type: "mcq",
      points: 0,
      national: langCode,
      vocabularies: [],
      grammars: [],
      listenings: [],
    };

    switch (category) {
      case LESSON_CATEGORIES.VOCABULARY:
        return [
          {
            ...baseExercise,
            points: 5,
            vocabularies: data.questions.map((q) => ({
              question: q.text,
              choices: [q.optionA, q.optionB],
              correctAnswer: q.correct === "A" ? q.optionA : q.optionB,
            })),
          },
        ];

      case LESSON_CATEGORIES.GRAMMAR:
        return [
          {
            ...baseExercise,
            grammars: data.grammarExamples.map((ex) => ({
              grammarRule: ex.grammarRule,
              example: ex.example,
              meaning: ex.meaning,
            })),
          },
        ];

      case LESSON_CATEGORIES.LISTENING:
        return [
          {
            ...baseExercise,
            listenings: data.listenings.map((l) => ({
              transcript: l.transcript,
              choices: l.choices,
              correctAnswer: l.correctAnswer,
              mediaId: null,
            })),
          },
        ];

      case LESSON_CATEGORIES.PRONUNCIATION:
        return [
          {
            type: "listening",
            points: 0,
            national: langCode,
            vocabularies: [],
            grammars: [],
            listenings: data.pronunciationExamples.map((ex) => ({
              example: ex.text,
              meaning: "",
            })),
          },
        ];

      case LESSON_CATEGORIES.VIDEO:
        if (!data.videoData?.transcriptions) return [];
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
                linkVideo: data.videoData.fileName,
                transl: data.videoData.transcriptions.map((item) => ({
                  vi: item.vi,
                  en: item.en,
                  ko: item.ko,
                })),
              },
            ],
          },
        ];

      default:
        return [];
    }
  }

  static createLessonPayload(formData, langCode, translatedData, prerequisiteId) {
    return {
      title: translatedData?.title || formData.title,
      description: formData.description,
      category: formData.category,
      level: formData.level,
      prerequisiteLesson: prerequisiteId,
      mediaId: formData.preview || null,
      exercises: this.buildExercises(
        formData.category,
        translatedData || formData,
        langCode
      ),
    };
  }
}