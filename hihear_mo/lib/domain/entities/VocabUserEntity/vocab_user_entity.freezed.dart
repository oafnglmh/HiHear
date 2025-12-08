// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vocab_user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VocabUserEntity {

 String get id; String get word; String get meaning;
/// Create a copy of VocabUserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VocabUserEntityCopyWith<VocabUserEntity> get copyWith => _$VocabUserEntityCopyWithImpl<VocabUserEntity>(this as VocabUserEntity, _$identity);

  /// Serializes this VocabUserEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VocabUserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.word, word) || other.word == word)&&(identical(other.meaning, meaning) || other.meaning == meaning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,word,meaning);

@override
String toString() {
  return 'VocabUserEntity(id: $id, word: $word, meaning: $meaning)';
}


}

/// @nodoc
abstract mixin class $VocabUserEntityCopyWith<$Res>  {
  factory $VocabUserEntityCopyWith(VocabUserEntity value, $Res Function(VocabUserEntity) _then) = _$VocabUserEntityCopyWithImpl;
@useResult
$Res call({
 String id, String word, String meaning
});




}
/// @nodoc
class _$VocabUserEntityCopyWithImpl<$Res>
    implements $VocabUserEntityCopyWith<$Res> {
  _$VocabUserEntityCopyWithImpl(this._self, this._then);

  final VocabUserEntity _self;
  final $Res Function(VocabUserEntity) _then;

/// Create a copy of VocabUserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? word = null,Object? meaning = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VocabUserEntity].
extension VocabUserEntityPatterns on VocabUserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VocabUserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VocabUserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VocabUserEntity value)  $default,){
final _that = this;
switch (_that) {
case _VocabUserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VocabUserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _VocabUserEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String word,  String meaning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VocabUserEntity() when $default != null:
return $default(_that.id,_that.word,_that.meaning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String word,  String meaning)  $default,) {final _that = this;
switch (_that) {
case _VocabUserEntity():
return $default(_that.id,_that.word,_that.meaning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String word,  String meaning)?  $default,) {final _that = this;
switch (_that) {
case _VocabUserEntity() when $default != null:
return $default(_that.id,_that.word,_that.meaning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VocabUserEntity implements VocabUserEntity {
  const _VocabUserEntity({required this.id, required this.word, required this.meaning});
  factory _VocabUserEntity.fromJson(Map<String, dynamic> json) => _$VocabUserEntityFromJson(json);

@override final  String id;
@override final  String word;
@override final  String meaning;

/// Create a copy of VocabUserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VocabUserEntityCopyWith<_VocabUserEntity> get copyWith => __$VocabUserEntityCopyWithImpl<_VocabUserEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VocabUserEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VocabUserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.word, word) || other.word == word)&&(identical(other.meaning, meaning) || other.meaning == meaning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,word,meaning);

@override
String toString() {
  return 'VocabUserEntity(id: $id, word: $word, meaning: $meaning)';
}


}

/// @nodoc
abstract mixin class _$VocabUserEntityCopyWith<$Res> implements $VocabUserEntityCopyWith<$Res> {
  factory _$VocabUserEntityCopyWith(_VocabUserEntity value, $Res Function(_VocabUserEntity) _then) = __$VocabUserEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String word, String meaning
});




}
/// @nodoc
class __$VocabUserEntityCopyWithImpl<$Res>
    implements _$VocabUserEntityCopyWith<$Res> {
  __$VocabUserEntityCopyWithImpl(this._self, this._then);

  final _VocabUserEntity _self;
  final $Res Function(_VocabUserEntity) _then;

/// Create a copy of VocabUserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? word = null,Object? meaning = null,}) {
  return _then(_VocabUserEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
