// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CountryEntity _$CountryEntityFromJson(Map<String, dynamic> json) =>
    _CountryEntity(
      name: json['name'] as String,
      code: json['code'] as String,
      flag: json['flag'] as String,
    );

Map<String, dynamic> _$CountryEntityToJson(_CountryEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'flag': instance.flag,
    };
