// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MediaEntity {

 String get id; String get url; String get type;
/// Create a copy of MediaEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaEntityCopyWith<MediaEntity> get copyWith => _$MediaEntityCopyWithImpl<MediaEntity>(this as MediaEntity, _$identity);

  /// Serializes this MediaEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,type);

@override
String toString() {
  return 'MediaEntity(id: $id, url: $url, type: $type)';
}


}

/// @nodoc
abstract mixin class $MediaEntityCopyWith<$Res>  {
  factory $MediaEntityCopyWith(MediaEntity value, $Res Function(MediaEntity) _then) = _$MediaEntityCopyWithImpl;
@useResult
$Res call({
 String id, String url, String type
});




}
/// @nodoc
class _$MediaEntityCopyWithImpl<$Res>
    implements $MediaEntityCopyWith<$Res> {
  _$MediaEntityCopyWithImpl(this._self, this._then);

  final MediaEntity _self;
  final $Res Function(MediaEntity) _then;

/// Create a copy of MediaEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaEntity].
extension MediaEntityPatterns on MediaEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaEntity value)  $default,){
final _that = this;
switch (_that) {
case _MediaEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MediaEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String url,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaEntity() when $default != null:
return $default(_that.id,_that.url,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String url,  String type)  $default,) {final _that = this;
switch (_that) {
case _MediaEntity():
return $default(_that.id,_that.url,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String url,  String type)?  $default,) {final _that = this;
switch (_that) {
case _MediaEntity() when $default != null:
return $default(_that.id,_that.url,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaEntity implements MediaEntity {
  const _MediaEntity({required this.id, required this.url, required this.type});
  factory _MediaEntity.fromJson(Map<String, dynamic> json) => _$MediaEntityFromJson(json);

@override final  String id;
@override final  String url;
@override final  String type;

/// Create a copy of MediaEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaEntityCopyWith<_MediaEntity> get copyWith => __$MediaEntityCopyWithImpl<_MediaEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,type);

@override
String toString() {
  return 'MediaEntity(id: $id, url: $url, type: $type)';
}


}

/// @nodoc
abstract mixin class _$MediaEntityCopyWith<$Res> implements $MediaEntityCopyWith<$Res> {
  factory _$MediaEntityCopyWith(_MediaEntity value, $Res Function(_MediaEntity) _then) = __$MediaEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String url, String type
});




}
/// @nodoc
class __$MediaEntityCopyWithImpl<$Res>
    implements _$MediaEntityCopyWith<$Res> {
  __$MediaEntityCopyWithImpl(this._self, this._then);

  final _MediaEntity _self;
  final $Res Function(_MediaEntity) _then;

/// Create a copy of MediaEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? type = null,}) {
  return _then(_MediaEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
