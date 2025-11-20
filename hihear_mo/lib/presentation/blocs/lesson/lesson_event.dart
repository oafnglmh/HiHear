part of 'lesson_bloc.dart';

@freezed
class LessionEvent with _$LessionEvent {
  const factory LessionEvent.loadLession() = _LoadLession;
  const factory LessionEvent.loadLessonById(String id) = _LoadLessonById;
}
