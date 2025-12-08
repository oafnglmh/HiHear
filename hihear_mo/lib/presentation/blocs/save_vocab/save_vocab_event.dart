part of 'save_vocab_bloc.dart';

@freezed
abstract class SaveVocabEvent with _$SaveVocabEvent {
  const factory SaveVocabEvent.loadVocabUserById({required String id}) = _LoadVocabUserById;
}

