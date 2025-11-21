import 'package:freezed_annotation/freezed_annotation.dart';

part 'grammar_entity.freezed.dart';
part 'grammar_entity.g.dart';

@freezed
abstract class GrammarEntity with _$GrammarEntity {
  const factory GrammarEntity({
    required String id,
    required String grammarRule,
    required String example,
    required String meaning,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GrammarEntity;

  factory GrammarEntity.fromJson(Map<String, dynamic> json) =>
      _$GrammarEntityFromJson(json);
}
