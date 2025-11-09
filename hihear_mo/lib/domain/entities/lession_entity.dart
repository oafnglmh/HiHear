import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _LessionEntity;

  factory LessionEntity.fromJson(Map<String, dynamic> json) =>
      _$LessionEntityFromJson(json);
}

