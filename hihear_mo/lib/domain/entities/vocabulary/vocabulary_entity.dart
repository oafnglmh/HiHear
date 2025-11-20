import 'package:freezed_annotation/freezed_annotation.dart';
part 'vocabulary_entity.freezed.dart';
part 'vocabulary_entity.g.dart';
@freezed
abstract class VocabularyEntity with _$VocabularyEntity {
  const factory VocabularyEntity({
    required String id,
    required String question,
    required List<String> choices,
    required String correctAnswer,
    required String createdAt,
    required String updatedAt,
  }) = _VocabularyEntity;

  factory VocabularyEntity.fromJson(Map<String, dynamic> json) =>
      _$VocabularyEntityFromJson(json);
}
