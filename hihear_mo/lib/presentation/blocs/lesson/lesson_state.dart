part of 'lesson_bloc.dart';

@freezed
class LessonState with _$LessonState {
  const factory LessonState.initial() = _Initial;
  const factory LessonState.loading() = _Loading;
  const factory LessonState.data(List<LessionEntity> lessons) = _Data;
  const factory LessonState.error(String message) = _Error;
  const factory LessonState.nextLessonLoaded(
    LessionEntity lesson,
  ) = _NextLessonLoaded;
  // const factory LessonState.saved() = _Saved;
}
