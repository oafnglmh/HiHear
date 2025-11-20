// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseEntity {

 String get id; String? get lessonId; String get type; int get points; String get national; List<VocabularyEntity> get vocabularies; List<GrammarEntity> get grammars; List<ListeningEntity> get listenings;
/// Create a copy of ExerciseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseEntityCopyWith<ExerciseEntity> get copyWith => _$ExerciseEntityCopyWithImpl<ExerciseEntity>(this as ExerciseEntity, _$identity);

  /// Serializes this ExerciseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.type, type) || other.type == type)&&(identical(other.points, points) || other.points == points)&&(identical(other.national, national) || other.national == national)&&const DeepCollectionEquality().equals(other.vocabularies, vocabularies)&&const DeepCollectionEquality().equals(other.grammars, grammars)&&const DeepCollectionEquality().equals(other.listenings, listenings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lessonId,type,points,national,const DeepCollectionEquality().hash(vocabularies),const DeepCollectionEquality().hash(grammars),const DeepCollectionEquality().hash(listenings));

@override
String toString() {
  return 'ExerciseEntity(id: $id, lessonId: $lessonId, type: $type, points: $points, national: $national, vocabularies: $vocabularies, grammars: $grammars, listenings: $listenings)';
}


}

/// @nodoc
abstract mixin class $ExerciseEntityCopyWith<$Res>  {
  factory $ExerciseEntityCopyWith(ExerciseEntity value, $Res Function(ExerciseEntity) _then) = _$ExerciseEntityCopyWithImpl;
@useResult
$Res call({
 String id, String? lessonId, String type, int points, String national, List<VocabularyEntity> vocabularies, List<GrammarEntity> grammars, List<ListeningEntity> listenings
});




}
/// @nodoc
class _$ExerciseEntityCopyWithImpl<$Res>
    implements $ExerciseEntityCopyWith<$Res> {
  _$ExerciseEntityCopyWithImpl(this._self, this._then);

  final ExerciseEntity _self;
  final $Res Function(ExerciseEntity) _then;

/// Create a copy of ExerciseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? lessonId = freezed,Object? type = null,Object? points = null,Object? national = null,Object? vocabularies = null,Object? grammars = null,Object? listenings = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lessonId: freezed == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,national: null == national ? _self.national : national // ignore: cast_nullable_to_non_nullable
as String,vocabularies: null == vocabularies ? _self.vocabularies : vocabularies // ignore: cast_nullable_to_non_nullable
as List<VocabularyEntity>,grammars: null == grammars ? _self.grammars : grammars // ignore: cast_nullable_to_non_nullable
as List<GrammarEntity>,listenings: null == listenings ? _self.listenings : listenings // ignore: cast_nullable_to_non_nullable
as List<ListeningEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseEntity].
extension ExerciseEntityPatterns on ExerciseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseEntity value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? lessonId,  String type,  int points,  String national,  List<VocabularyEntity> vocabularies,  List<GrammarEntity> grammars,  List<ListeningEntity> listenings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseEntity() when $default != null:
return $default(_that.id,_that.lessonId,_that.type,_that.points,_that.national,_that.vocabularies,_that.grammars,_that.listenings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? lessonId,  String type,  int points,  String national,  List<VocabularyEntity> vocabularies,  List<GrammarEntity> grammars,  List<ListeningEntity> listenings)  $default,) {final _that = this;
switch (_that) {
case _ExerciseEntity():
return $default(_that.id,_that.lessonId,_that.type,_that.points,_that.national,_that.vocabularies,_that.grammars,_that.listenings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? lessonId,  String type,  int points,  String national,  List<VocabularyEntity> vocabularies,  List<GrammarEntity> grammars,  List<ListeningEntity> listenings)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseEntity() when $default != null:
return $default(_that.id,_that.lessonId,_that.type,_that.points,_that.national,_that.vocabularies,_that.grammars,_that.listenings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExerciseEntity implements ExerciseEntity {
  const _ExerciseEntity({required this.id, this.lessonId, required this.type, required this.points, required this.national, final  List<VocabularyEntity> vocabularies = const [], final  List<GrammarEntity> grammars = const [], final  List<ListeningEntity> listenings = const []}): _vocabularies = vocabularies,_grammars = grammars,_listenings = listenings;
  factory _ExerciseEntity.fromJson(Map<String, dynamic> json) => _$ExerciseEntityFromJson(json);

@override final  String id;
@override final  String? lessonId;
@override final  String type;
@override final  int points;
@override final  String national;
 final  List<VocabularyEntity> _vocabularies;
@override@JsonKey() List<VocabularyEntity> get vocabularies {
  if (_vocabularies is EqualUnmodifiableListView) return _vocabularies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vocabularies);
}

 final  List<GrammarEntity> _grammars;
@override@JsonKey() List<GrammarEntity> get grammars {
  if (_grammars is EqualUnmodifiableListView) return _grammars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_grammars);
}

 final  List<ListeningEntity> _listenings;
@override@JsonKey() List<ListeningEntity> get listenings {
  if (_listenings is EqualUnmodifiableListView) return _listenings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listenings);
}


/// Create a copy of ExerciseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseEntityCopyWith<_ExerciseEntity> get copyWith => __$ExerciseEntityCopyWithImpl<_ExerciseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.type, type) || other.type == type)&&(identical(other.points, points) || other.points == points)&&(identical(other.national, national) || other.national == national)&&const DeepCollectionEquality().equals(other._vocabularies, _vocabularies)&&const DeepCollectionEquality().equals(other._grammars, _grammars)&&const DeepCollectionEquality().equals(other._listenings, _listenings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lessonId,type,points,national,const DeepCollectionEquality().hash(_vocabularies),const DeepCollectionEquality().hash(_grammars),const DeepCollectionEquality().hash(_listenings));

@override
String toString() {
  return 'ExerciseEntity(id: $id, lessonId: $lessonId, type: $type, points: $points, national: $national, vocabularies: $vocabularies, grammars: $grammars, listenings: $listenings)';
}


}

/// @nodoc
abstract mixin class _$ExerciseEntityCopyWith<$Res> implements $ExerciseEntityCopyWith<$Res> {
  factory _$ExerciseEntityCopyWith(_ExerciseEntity value, $Res Function(_ExerciseEntity) _then) = __$ExerciseEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String? lessonId, String type, int points, String national, List<VocabularyEntity> vocabularies, List<GrammarEntity> grammars, List<ListeningEntity> listenings
});




}
/// @nodoc
class __$ExerciseEntityCopyWithImpl<$Res>
    implements _$ExerciseEntityCopyWith<$Res> {
  __$ExerciseEntityCopyWithImpl(this._self, this._then);

  final _ExerciseEntity _self;
  final $Res Function(_ExerciseEntity) _then;

/// Create a copy of ExerciseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? lessonId = freezed,Object? type = null,Object? points = null,Object? national = null,Object? vocabularies = null,Object? grammars = null,Object? listenings = null,}) {
  return _then(_ExerciseEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lessonId: freezed == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,national: null == national ? _self.national : national // ignore: cast_nullable_to_non_nullable
as String,vocabularies: null == vocabularies ? _self._vocabularies : vocabularies // ignore: cast_nullable_to_non_nullable
as List<VocabularyEntity>,grammars: null == grammars ? _self._grammars : grammars // ignore: cast_nullable_to_non_nullable
as List<GrammarEntity>,listenings: null == listenings ? _self._listenings : listenings // ignore: cast_nullable_to_non_nullable
as List<ListeningEntity>,
  ));
}


}

// dart format on
