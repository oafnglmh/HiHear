import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/domain/entities/lession_entity.dart';
import 'package:hihear_mo/domain/repositories/lession_repository.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_bloc.freezed.dart';
part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessionEvent, LessonState> {
  final LessonRepository repository;

  LessonBloc({required this.repository}) : super(const LessonState.initial()) {
    on<_LoadLession>(_onLoadLession);
  }

  Future<void> _onLoadLession(
    _LoadLession event,
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
}
