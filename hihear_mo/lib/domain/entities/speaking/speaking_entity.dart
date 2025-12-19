import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hihear_mo/domain/entities/grammar/grammar_entity.dart';
import 'package:hihear_mo/domain/entities/listening/listening_entity.dart';
import 'package:hihear_mo/domain/entities/vocabulary/vocabulary_entity.dart';
part 'speaking_entity.freezed.dart';
part 'speaking_entity.g.dart';
@freezed
abstract class SpeakingEntity with _$SpeakingEntity {
  const factory SpeakingEntity({
    required String id,
    required String number,
    required List<String> read,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SpeakingEntity;

  factory SpeakingEntity.fromJson(Map<String, dynamic> json) =>
      _$SpeakingEntityFromJson(json);
}