import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_entity.freezed.dart';
part 'country_entity.g.dart';

@freezed
abstract class CountryEntity with _$CountryEntity {
  const factory CountryEntity({
    required String name,
    required String code,
    required String flag,
  }) = _CountryEntity;

  factory CountryEntity.fromJson(Map<String, dynamic> json) =>
      _$CountryEntityFromJson(json);
}
