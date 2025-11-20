import 'package:freezed_annotation/freezed_annotation.dart';
part 'listening_entity.freezed.dart';
part 'listening_entity.g.dart';
@freezed
abstract class ListeningEntity with _$ListeningEntity {
  const factory ListeningEntity({
    required String id,
    required String audioUrl,
    required String answer,
  }) = _ListeningEntity;

  factory ListeningEntity.fromJson(Map<String, dynamic> json) =>
      _$ListeningEntityFromJson(json);
}
