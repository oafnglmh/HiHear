// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grammar_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GrammarEntity {

 String get id; String get grammarRule; String get example; String get meaning; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of GrammarEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GrammarEntityCopyWith<GrammarEntity> get copyWith => _$GrammarEntityCopyWithImpl<GrammarEntity>(this as GrammarEntity, _$identity);

  /// Serializes this GrammarEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GrammarEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.grammarRule, grammarRule) || other.grammarRule == grammarRule)&&(identical(other.example, example) || other.example == example)&&(identical(other.meaning, meaning) || other.meaning == meaning)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,grammarRule,example,meaning,createdAt,updatedAt);

@override
String toString() {
  return 'GrammarEntity(id: $id, grammarRule: $grammarRule, example: $example, meaning: $meaning, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GrammarEntityCopyWith<$Res>  {
  factory $GrammarEntityCopyWith(GrammarEntity value, $Res Function(GrammarEntity) _then) = _$GrammarEntityCopyWithImpl;
@useResult
$Res call({
 String id, String grammarRule, String example, String meaning, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$GrammarEntityCopyWithImpl<$Res>
    implements $GrammarEntityCopyWith<$Res> {
  _$GrammarEntityCopyWithImpl(this._self, this._then);

  final GrammarEntity _self;
  final $Res Function(GrammarEntity) _then;

/// Create a copy of GrammarEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? grammarRule = null,Object? example = null,Object? meaning = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,grammarRule: null == grammarRule ? _self.grammarRule : grammarRule // ignore: cast_nullable_to_non_nullable
as String,example: null == example ? _self.example : example // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GrammarEntity].
extension GrammarEntityPatterns on GrammarEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GrammarEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GrammarEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GrammarEntity value)  $default,){
final _that = this;
switch (_that) {
case _GrammarEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GrammarEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GrammarEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String grammarRule,  String example,  String meaning,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GrammarEntity() when $default != null:
return $default(_that.id,_that.grammarRule,_that.example,_that.meaning,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String grammarRule,  String example,  String meaning,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _GrammarEntity():
return $default(_that.id,_that.grammarRule,_that.example,_that.meaning,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String grammarRule,  String example,  String meaning,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _GrammarEntity() when $default != null:
return $default(_that.id,_that.grammarRule,_that.example,_that.meaning,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GrammarEntity implements GrammarEntity {
  const _GrammarEntity({required this.id, required this.grammarRule, required this.example, required this.meaning, required this.createdAt, required this.updatedAt});
  factory _GrammarEntity.fromJson(Map<String, dynamic> json) => _$GrammarEntityFromJson(json);

@override final  String id;
@override final  String grammarRule;
@override final  String example;
@override final  String meaning;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of GrammarEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GrammarEntityCopyWith<_GrammarEntity> get copyWith => __$GrammarEntityCopyWithImpl<_GrammarEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GrammarEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GrammarEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.grammarRule, grammarRule) || other.grammarRule == grammarRule)&&(identical(other.example, example) || other.example == example)&&(identical(other.meaning, meaning) || other.meaning == meaning)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,grammarRule,example,meaning,createdAt,updatedAt);

@override
String toString() {
  return 'GrammarEntity(id: $id, grammarRule: $grammarRule, example: $example, meaning: $meaning, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GrammarEntityCopyWith<$Res> implements $GrammarEntityCopyWith<$Res> {
  factory _$GrammarEntityCopyWith(_GrammarEntity value, $Res Function(_GrammarEntity) _then) = __$GrammarEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String grammarRule, String example, String meaning, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$GrammarEntityCopyWithImpl<$Res>
    implements _$GrammarEntityCopyWith<$Res> {
  __$GrammarEntityCopyWithImpl(this._self, this._then);

  final _GrammarEntity _self;
  final $Res Function(_GrammarEntity) _then;

/// Create a copy of GrammarEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? grammarRule = null,Object? example = null,Object? meaning = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_GrammarEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,grammarRule: null == grammarRule ? _self.grammarRule : grammarRule // ignore: cast_nullable_to_non_nullable
as String,example: null == example ? _self.example : example // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
