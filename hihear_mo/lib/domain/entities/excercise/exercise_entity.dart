import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hihear_mo/domain/entities/grammar/grammar_entity.dart';
import 'package:hihear_mo/domain/entities/listening/listening_entity.dart';
import 'package:hihear_mo/domain/entities/vocabulary/vocabulary_entity.dart';
part 'exercise_entity.freezed.dart';
part 'exercise_entity.g.dart';
@freezed
abstract class ExerciseEntity with _$ExerciseEntity {
  const factory ExerciseEntity({
    required String id,
    String? lessonId,
    required String type,
    required int points,
    required String national,
    @Default([]) List<VocabularyEntity> vocabularies,
    @Default([]) List<GrammarEntity> grammars,
    @Default([]) List<ListeningEntity> listenings,
  }) = _ExerciseEntity;

  factory ExerciseEntity.fromJson(Map<String, dynamic> json) =>
      _$ExerciseEntityFromJson(json);
}
