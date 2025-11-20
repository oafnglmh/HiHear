import 'package:freezed_annotation/freezed_annotation.dart';
part 'grammar_entity.freezed.dart';
part 'grammar_entity.g.dart';
@freezed
abstract class GrammarEntity with _$GrammarEntity {
  const factory GrammarEntity({
    required String id,
    required String question,
    required String answer,
  }) = _GrammarEntity;

  factory GrammarEntity.fromJson(Map<String, dynamic> json) =>
      _$GrammarEntityFromJson(json);
}
