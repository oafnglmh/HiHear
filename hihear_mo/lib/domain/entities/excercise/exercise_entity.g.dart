// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseEntity _$ExerciseEntityFromJson(Map<String, dynamic> json) =>
    _ExerciseEntity(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String?,
      type: json['type'] as String,
      points: (json['points'] as num).toInt(),
      national: json['national'] as String,
      vocabularies:
          (json['vocabularies'] as List<dynamic>?)
              ?.map((e) => VocabularyEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      grammars:
          (json['grammars'] as List<dynamic>?)
              ?.map((e) => GrammarEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      listenings:
          (json['listenings'] as List<dynamic>?)
              ?.map((e) => ListeningEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      speakings:
          (json['speakings'] as List<dynamic>?)
              ?.map((e) => SpeakingEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExerciseEntityToJson(_ExerciseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'type': instance.type,
      'points': instance.points,
      'national': instance.national,
      'vocabularies': instance.vocabularies,
      'grammars': instance.grammars,
      'listenings': instance.listenings,
      'speakings': instance.speakings,
    };
