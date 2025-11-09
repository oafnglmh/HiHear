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
      prerequisiteLesson: json['prerequisiteLesson'] as String?,
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
      'prerequisiteLesson': instance.prerequisiteLesson,
    };
