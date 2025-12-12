export class LessonMapper {
  static mapApiLessonToFormData(lesson) {
    const mcqExercise = lesson.exercises?.find((ex) => ex.type === "mcq");
    const listeningExercise = lesson.exercises?.filter(
      (ex) => ex.type === "listening"
    );

    return {
      ...lesson,
      questions: this.mapVocabularyQuestions(mcqExercise),
      grammarExamples: this.mapGrammarExamples(lesson.exercises),
      pronunciationExamples: this.mapPronunciationExamples(listeningExercise),
      listenings: this.mapListenings(mcqExercise),
      videoData: this.mapVideoData(mcqExercise),
    };
  }

  static mapVocabularyQuestions(mcqExercise) {
    if (!mcqExercise?.vocabularies) return [];

    return mcqExercise.vocabularies.map((v, idx) => ({
      id: v.id || idx,
      text: v.question || "",
      optionA: v.choices?.[0] || "",
      optionB: v.choices?.[1] || "",
      correct: v.correctAnswer === v.choices?.[0] ? "A" : "B",
    }));
  }

  static mapGrammarExamples(exercises) {
    if (!exercises) return [];

    const grammarExercises = exercises.filter((ex) => ex.type === "grammar");
    return grammarExercises.flatMap(
      (ex) =>
        ex.grammars?.map((g, idx) => ({
          id: g.id || idx,
          grammarRule: g.grammarRule || "",
          example: g.example || "",
          meaning: g.meaning || "",
        })) || []
    );
  }

  static mapPronunciationExamples(listeningExercises) {
    if (!listeningExercises) return [];

    return listeningExercises.flatMap(
      (ex) =>
        ex.listenings?.map((p, idx) => ({
          id: p.id || idx,
          text: p.example || "",
        })) || []
    );
  }

  static mapListenings(mcqExercise) {
    if (!mcqExercise?.listenings) return [];

    return mcqExercise.listenings.map((l) => ({
      transcript: l.transcript || "",
      choices: l.choices || [],
      correctAnswer: l.correctAnswer || "",
    }));
  }

  static mapVideoData(mcqExercise) {
    const video = mcqExercise?.video?.[0];
    if (!video) return null;

    return {
      fileName: video.linkVideo,
      transcriptions: video.transl || [],
    };
  }
}