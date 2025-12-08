import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hihear_mo/domain/entities/excercise/exercise_entity.dart';
import 'package:hihear_mo/domain/entities/media/media_entity.dart';

part 'vocab_user_entity.freezed.dart';
part 'vocab_user_entity.g.dart';

@freezed
abstract class VocabUserEntity with _$VocabUserEntity {
  const factory VocabUserEntity({
    required String id,
    required String word,
    required String meaning,
  }) = _VocabUserEntity;

  factory VocabUserEntity.fromJson(Map<String, dynamic> json) =>
      _$VocabUserEntityFromJson(json);
}
