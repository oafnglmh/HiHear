import 'package:freezed_annotation/freezed_annotation.dart';
part 'media_entity.freezed.dart';
part 'media_entity.g.dart';
@freezed
abstract class MediaEntity with _$MediaEntity {
  const factory MediaEntity({
    required String id,
    required String url,
    required String type,
  }) = _MediaEntity;

  factory MediaEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaEntityFromJson(json);
}
