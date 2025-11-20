// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lession_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LessionEntity {

 String get id; String get title; String get category; String get level; String get description; int get durationSeconds; int? get xpReward; String? get prerequisiteLesson; List<MediaEntity> get media; List<ExerciseEntity> get exercises;
/// Create a copy of LessionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessionEntityCopyWith<LessionEntity> get copyWith => _$LessionEntityCopyWithImpl<LessionEntity>(this as LessionEntity, _$identity);

  /// Serializes this LessionEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.level, level) || other.level == level)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.xpReward, xpReward) || other.xpReward == xpReward)&&(identical(other.prerequisiteLesson, prerequisiteLesson) || other.prerequisiteLesson == prerequisiteLesson)&&const DeepCollectionEquality().equals(other.media, media)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,category,level,description,durationSeconds,xpReward,prerequisiteLesson,const DeepCollectionEquality().hash(media),const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'LessionEntity(id: $id, title: $title, category: $category, level: $level, description: $description, durationSeconds: $durationSeconds, xpReward: $xpReward, prerequisiteLesson: $prerequisiteLesson, media: $media, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $LessionEntityCopyWith<$Res>  {
  factory $LessionEntityCopyWith(LessionEntity value, $Res Function(LessionEntity) _then) = _$LessionEntityCopyWithImpl;
@useResult
$Res call({
 String id, String title, String category, String level, String description, int durationSeconds, int? xpReward, String? prerequisiteLesson, List<MediaEntity> media, List<ExerciseEntity> exercises
});




}
/// @nodoc
class _$LessionEntityCopyWithImpl<$Res>
    implements $LessionEntityCopyWith<$Res> {
  _$LessionEntityCopyWithImpl(this._self, this._then);

  final LessionEntity _self;
  final $Res Function(LessionEntity) _then;

/// Create a copy of LessionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? category = null,Object? level = null,Object? description = null,Object? durationSeconds = null,Object? xpReward = freezed,Object? prerequisiteLesson = freezed,Object? media = null,Object? exercises = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,xpReward: freezed == xpReward ? _self.xpReward : xpReward // ignore: cast_nullable_to_non_nullable
as int?,prerequisiteLesson: freezed == prerequisiteLesson ? _self.prerequisiteLesson : prerequisiteLesson // ignore: cast_nullable_to_non_nullable
as String?,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<MediaEntity>,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [LessionEntity].
extension LessionEntityPatterns on LessionEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessionEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessionEntity value)  $default,){
final _that = this;
switch (_that) {
case _LessionEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LessionEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String category,  String level,  String description,  int durationSeconds,  int? xpReward,  String? prerequisiteLesson,  List<MediaEntity> media,  List<ExerciseEntity> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessionEntity() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.level,_that.description,_that.durationSeconds,_that.xpReward,_that.prerequisiteLesson,_that.media,_that.exercises);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String category,  String level,  String description,  int durationSeconds,  int? xpReward,  String? prerequisiteLesson,  List<MediaEntity> media,  List<ExerciseEntity> exercises)  $default,) {final _that = this;
switch (_that) {
case _LessionEntity():
return $default(_that.id,_that.title,_that.category,_that.level,_that.description,_that.durationSeconds,_that.xpReward,_that.prerequisiteLesson,_that.media,_that.exercises);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String category,  String level,  String description,  int durationSeconds,  int? xpReward,  String? prerequisiteLesson,  List<MediaEntity> media,  List<ExerciseEntity> exercises)?  $default,) {final _that = this;
switch (_that) {
case _LessionEntity() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.level,_that.description,_that.durationSeconds,_that.xpReward,_that.prerequisiteLesson,_that.media,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LessionEntity implements LessionEntity {
  const _LessionEntity({required this.id, required this.title, required this.category, required this.level, required this.description, required this.durationSeconds, this.xpReward, this.prerequisiteLesson, final  List<MediaEntity> media = const [], final  List<ExerciseEntity> exercises = const []}): _media = media,_exercises = exercises;
  factory _LessionEntity.fromJson(Map<String, dynamic> json) => _$LessionEntityFromJson(json);

@override final  String id;
@override final  String title;
@override final  String category;
@override final  String level;
@override final  String description;
@override final  int durationSeconds;
@override final  int? xpReward;
@override final  String? prerequisiteLesson;
 final  List<MediaEntity> _media;
@override@JsonKey() List<MediaEntity> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}

 final  List<ExerciseEntity> _exercises;
@override@JsonKey() List<ExerciseEntity> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of LessionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessionEntityCopyWith<_LessionEntity> get copyWith => __$LessionEntityCopyWithImpl<_LessionEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessionEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.level, level) || other.level == level)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.xpReward, xpReward) || other.xpReward == xpReward)&&(identical(other.prerequisiteLesson, prerequisiteLesson) || other.prerequisiteLesson == prerequisiteLesson)&&const DeepCollectionEquality().equals(other._media, _media)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,category,level,description,durationSeconds,xpReward,prerequisiteLesson,const DeepCollectionEquality().hash(_media),const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'LessionEntity(id: $id, title: $title, category: $category, level: $level, description: $description, durationSeconds: $durationSeconds, xpReward: $xpReward, prerequisiteLesson: $prerequisiteLesson, media: $media, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$LessionEntityCopyWith<$Res> implements $LessionEntityCopyWith<$Res> {
  factory _$LessionEntityCopyWith(_LessionEntity value, $Res Function(_LessionEntity) _then) = __$LessionEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String category, String level, String description, int durationSeconds, int? xpReward, String? prerequisiteLesson, List<MediaEntity> media, List<ExerciseEntity> exercises
});




}
/// @nodoc
class __$LessionEntityCopyWithImpl<$Res>
    implements _$LessionEntityCopyWith<$Res> {
  __$LessionEntityCopyWithImpl(this._self, this._then);

  final _LessionEntity _self;
  final $Res Function(_LessionEntity) _then;

/// Create a copy of LessionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? category = null,Object? level = null,Object? description = null,Object? durationSeconds = null,Object? xpReward = freezed,Object? prerequisiteLesson = freezed,Object? media = null,Object? exercises = null,}) {
  return _then(_LessionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,xpReward: freezed == xpReward ? _self.xpReward : xpReward // ignore: cast_nullable_to_non_nullable
as int?,prerequisiteLesson: freezed == prerequisiteLesson ? _self.prerequisiteLesson : prerequisiteLesson // ignore: cast_nullable_to_non_nullable
as String?,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<MediaEntity>,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseEntity>,
  ));
}


}

// dart format on
