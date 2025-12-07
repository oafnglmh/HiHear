import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/domain/repositories/lession_repository.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_bloc.freezed.dart';
part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LessonRepository repository;

  LessonBloc({required this.repository}) : super(const LessonState.initial()) {
    on<_LoadLesson>(_onLoadLesson);
    on<_LoadLessonById>(_onLoadLessonById);
    on<_SaveVocabulary>(_onSaveVocabulary);
  }

  Future<void> _onLoadLesson(
    _LoadLesson event,
    Emitter<LessonState> emit,
  ) async {
    emit(const LessonState.loading());
    try {
      final result = await repository.loadLessions();
      result.fold(
        (failure) {
          print('Load lessons failed: $failure');
          emit(LessonState.error(failure.toString()));
        },
        (lessons) {
          print('Loaded ${lessons.length} lessons');
          emit(LessonState.data(lessons));
        },
      );
    } catch (e, s) {
      emit(LessonState.error('Load lessons failed: $e'));
      addError(e, s);
    }
  }

  Future<void> _onLoadLessonById(
    _LoadLessonById event,
    Emitter<LessonState> emit,
  ) async {
    emit(const LessonState.loading());
    try {
      final result = await repository.getLessonById(event.id);
      result.fold(
        (failure) {
          emit(LessonState.error(failure.toString()));
        },
        (lesson) {
          emit(LessonState.data([lesson]));
        },
      );
    } catch (e, s) {
      emit(LessonState.error('Load lesson by id failed: $e'));
      addError(e, s);
    }
  }

  Future<void> _onSaveVocabulary(
    _SaveVocabulary event,
    Emitter<LessonState> emit,
  ) async {
    emit(const LessonState.loading());

    try {
      final result = await repository.saveVocabulary(
        word: event.word,
        meaning: event.meaning,
        category: event.category,
        userId: event.userId,
      );

      result.fold(
        (failure) {
          print('Save vocab failed: $failure');
          emit(LessonState.error(failure.toString()));
        },
        (_) {
          print('Vocabulary saved successfully');
          emit(const LessonState.saved());
        },
      );
    } catch (e, s) {
      emit(LessonState.error('Save vocabulary failed: $e'));
      addError(e, s);
    }
  }
}
