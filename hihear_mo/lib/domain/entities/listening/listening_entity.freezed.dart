// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listening_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListeningEntity {

 String get id; String get audioUrl; String get answer;
/// Create a copy of ListeningEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListeningEntityCopyWith<ListeningEntity> get copyWith => _$ListeningEntityCopyWithImpl<ListeningEntity>(this as ListeningEntity, _$identity);

  /// Serializes this ListeningEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListeningEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,audioUrl,answer);

@override
String toString() {
  return 'ListeningEntity(id: $id, audioUrl: $audioUrl, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $ListeningEntityCopyWith<$Res>  {
  factory $ListeningEntityCopyWith(ListeningEntity value, $Res Function(ListeningEntity) _then) = _$ListeningEntityCopyWithImpl;
@useResult
$Res call({
 String id, String audioUrl, String answer
});




}
/// @nodoc
class _$ListeningEntityCopyWithImpl<$Res>
    implements $ListeningEntityCopyWith<$Res> {
  _$ListeningEntityCopyWithImpl(this._self, this._then);

  final ListeningEntity _self;
  final $Res Function(ListeningEntity) _then;

/// Create a copy of ListeningEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? audioUrl = null,Object? answer = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ListeningEntity].
extension ListeningEntityPatterns on ListeningEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListeningEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListeningEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListeningEntity value)  $default,){
final _that = this;
switch (_that) {
case _ListeningEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListeningEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ListeningEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String audioUrl,  String answer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListeningEntity() when $default != null:
return $default(_that.id,_that.audioUrl,_that.answer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String audioUrl,  String answer)  $default,) {final _that = this;
switch (_that) {
case _ListeningEntity():
return $default(_that.id,_that.audioUrl,_that.answer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String audioUrl,  String answer)?  $default,) {final _that = this;
switch (_that) {
case _ListeningEntity() when $default != null:
return $default(_that.id,_that.audioUrl,_that.answer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListeningEntity implements ListeningEntity {
  const _ListeningEntity({required this.id, required this.audioUrl, required this.answer});
  factory _ListeningEntity.fromJson(Map<String, dynamic> json) => _$ListeningEntityFromJson(json);

@override final  String id;
@override final  String audioUrl;
@override final  String answer;

/// Create a copy of ListeningEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListeningEntityCopyWith<_ListeningEntity> get copyWith => __$ListeningEntityCopyWithImpl<_ListeningEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListeningEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListeningEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,audioUrl,answer);

@override
String toString() {
  return 'ListeningEntity(id: $id, audioUrl: $audioUrl, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$ListeningEntityCopyWith<$Res> implements $ListeningEntityCopyWith<$Res> {
  factory _$ListeningEntityCopyWith(_ListeningEntity value, $Res Function(_ListeningEntity) _then) = __$ListeningEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String audioUrl, String answer
});




}
/// @nodoc
class __$ListeningEntityCopyWithImpl<$Res>
    implements _$ListeningEntityCopyWith<$Res> {
  __$ListeningEntityCopyWithImpl(this._self, this._then);

  final _ListeningEntity _self;
  final $Res Function(_ListeningEntity) _then;

/// Create a copy of ListeningEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? audioUrl = null,Object? answer = null,}) {
  return _then(_ListeningEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
