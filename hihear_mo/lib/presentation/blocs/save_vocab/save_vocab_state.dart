part of 'save_vocab_bloc.dart';

@freezed
class SaveVocabState with _$SaveVocabState {
  const factory SaveVocabState.initial() = _Initial;
  const factory SaveVocabState.loading() = _Loading;
  const factory SaveVocabState.error(String message) = _Error;
  const factory SaveVocabState.vocabUserData(List<VocabUserEntity> vocabUsers) = _VocabUserData;
}
