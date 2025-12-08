import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hihear_mo/domain/entities/excercise/exercise_entity.dart';
import 'package:hihear_mo/domain/entities/media/media_entity.dart';

part 'lession_entity.freezed.dart';
part 'lession_entity.g.dart';

@freezed
abstract class LessionEntity with _$LessionEntity {
  const factory LessionEntity({
    required String id,
    required String title,
    required String category,
    required String level,
    required String description,
    required int durationSeconds,
    int? xpReward,
    String? prerequisiteLesson,
    @Default(true) bool isLock,
    @Default([]) List<MediaEntity> media,
    @Default([]) List<ExerciseEntity> exercises,
  }) = _LessionEntity;

  factory LessionEntity.fromJson(Map<String, dynamic> json) =>
      _$LessionEntityFromJson(json);
}
