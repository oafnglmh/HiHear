import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/domain/entities/VocabUserEntity/vocab_user_entity.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/domain/repositories/lession_repository.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_vocab_bloc.freezed.dart';
part 'save_vocab_event.dart';
part 'save_vocab_state.dart';

class SaveVocabBloc extends Bloc<SaveVocabEvent, SaveVocabState> {
  final LessonRepository repository;

  SaveVocabBloc({required this.repository}) : super(const SaveVocabState.initial()) {
    on<_LoadVocabUserById>(_onLoadVocabUserById);
  }

  Future<void> _onLoadVocabUserById(
    _LoadVocabUserById event,
    Emitter<SaveVocabState> emit,
  ) async {
    emit(const SaveVocabState.loading());
    try {
      print('Loading vocab user by id: ${event.id}');
      final result = await repository.loadVocabUserById(event.id);
      result.fold(
        (failure) {
          emit(SaveVocabState.error(failure.toString()));
        },
        (vocabUsers) {
          emit(SaveVocabState.vocabUserData(vocabUsers));
        },
      );
    } catch (e, s) {
      emit(SaveVocabState.error('Load vocab user by id failed: $e'));
      addError(e, s);
    }
  }
}
