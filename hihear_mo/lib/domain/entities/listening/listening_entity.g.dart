// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListeningEntity _$ListeningEntityFromJson(Map<String, dynamic> json) =>
    _ListeningEntity(
      id: json['id'] as String,
      audioUrl: json['audioUrl'] as String,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$ListeningEntityToJson(_ListeningEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'audioUrl': instance.audioUrl,
      'answer': instance.answer,
    };
