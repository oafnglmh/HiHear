// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lession_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LessionEntity _$LessionEntityFromJson(Map<String, dynamic> json) =>
    _LessionEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      level: json['level'] as String,
      description: json['description'] as String,
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      xpReward: (json['xpReward'] as num?)?.toInt(),
      prerequisiteLessonId: json['prerequisiteLessonId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isLock: json['isLock'] as bool? ?? true,
      media:
          (json['media'] as List<dynamic>?)
              ?.map((e) => MediaEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      exercises:
          (json['exercises'] as List<dynamic>?)
              ?.map((e) => ExerciseEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LessionEntityToJson(_LessionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'level': instance.level,
      'description': instance.description,
      'durationSeconds': instance.durationSeconds,
      'xpReward': instance.xpReward,
      'prerequisiteLessonId': instance.prerequisiteLessonId,
      'createdAt': instance.createdAt.toIso8601String(),
      'isLock': instance.isLock,
      'media': instance.media,
      'exercises': instance.exercises,
    };
