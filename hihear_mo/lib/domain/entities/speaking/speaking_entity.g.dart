// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaking_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpeakingEntity _$SpeakingEntityFromJson(Map<String, dynamic> json) =>
    _SpeakingEntity(
      id: json['id'] as String,
      number: json['number'] as String,
      read: (json['read'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SpeakingEntityToJson(_SpeakingEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'read': instance.read,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
