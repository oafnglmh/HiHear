part of 'lesson_bloc.dart';

@freezed
class LessonEvent with _$LessonEvent {
  const factory LessonEvent.loadLesson() = _LoadLesson;
  const factory LessonEvent.loadNextLesson() = _LoadNextLesson;
  const factory LessonEvent.loadLessonBySpeak() = _LoadLessonBySpeak;
  const factory LessonEvent.loadLessonById(String id) = _LoadLessonById;
  const factory LessonEvent.saveVocabulary({
    required String word,
    required String meaning,
    required String category,
    required String userId,
  }) = _SaveVocabulary;
  const factory LessonEvent.saveCompleteLesson({
    required String lessonId,
    required String userId,
  }) = _SaveCompleteLesson;
}

