// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vocabulary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VocabularyEntity {

 String get id; String get question; List<String> get choices; String get correctAnswer; String get createdAt; String get updatedAt;
/// Create a copy of VocabularyEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VocabularyEntityCopyWith<VocabularyEntity> get copyWith => _$VocabularyEntityCopyWithImpl<VocabularyEntity>(this as VocabularyEntity, _$identity);

  /// Serializes this VocabularyEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VocabularyEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.choices, choices)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,const DeepCollectionEquality().hash(choices),correctAnswer,createdAt,updatedAt);

@override
String toString() {
  return 'VocabularyEntity(id: $id, question: $question, choices: $choices, correctAnswer: $correctAnswer, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $VocabularyEntityCopyWith<$Res>  {
  factory $VocabularyEntityCopyWith(VocabularyEntity value, $Res Function(VocabularyEntity) _then) = _$VocabularyEntityCopyWithImpl;
@useResult
$Res call({
 String id, String question, List<String> choices, String correctAnswer, String createdAt, String updatedAt
});




}
/// @nodoc
class _$VocabularyEntityCopyWithImpl<$Res>
    implements $VocabularyEntityCopyWith<$Res> {
  _$VocabularyEntityCopyWithImpl(this._self, this._then);

  final VocabularyEntity _self;
  final $Res Function(VocabularyEntity) _then;

/// Create a copy of VocabularyEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? choices = null,Object? correctAnswer = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>,correctAnswer: null == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VocabularyEntity].
extension VocabularyEntityPatterns on VocabularyEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VocabularyEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VocabularyEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VocabularyEntity value)  $default,){
final _that = this;
switch (_that) {
case _VocabularyEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VocabularyEntity value)?  $default,){
final _that = this;
switch (_that) {
case _VocabularyEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String question,  List<String> choices,  String correctAnswer,  String createdAt,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VocabularyEntity() when $default != null:
return $default(_that.id,_that.question,_that.choices,_that.correctAnswer,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String question,  List<String> choices,  String correctAnswer,  String createdAt,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _VocabularyEntity():
return $default(_that.id,_that.question,_that.choices,_that.correctAnswer,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String question,  List<String> choices,  String correctAnswer,  String createdAt,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _VocabularyEntity() when $default != null:
return $default(_that.id,_that.question,_that.choices,_that.correctAnswer,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VocabularyEntity implements VocabularyEntity {
  const _VocabularyEntity({required this.id, required this.question, required final  List<String> choices, required this.correctAnswer, required this.createdAt, required this.updatedAt}): _choices = choices;
  factory _VocabularyEntity.fromJson(Map<String, dynamic> json) => _$VocabularyEntityFromJson(json);

@override final  String id;
@override final  String question;
 final  List<String> _choices;
@override List<String> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

@override final  String correctAnswer;
@override final  String createdAt;
@override final  String updatedAt;

/// Create a copy of VocabularyEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VocabularyEntityCopyWith<_VocabularyEntity> get copyWith => __$VocabularyEntityCopyWithImpl<_VocabularyEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VocabularyEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VocabularyEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._choices, _choices)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,const DeepCollectionEquality().hash(_choices),correctAnswer,createdAt,updatedAt);

@override
String toString() {
  return 'VocabularyEntity(id: $id, question: $question, choices: $choices, correctAnswer: $correctAnswer, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$VocabularyEntityCopyWith<$Res> implements $VocabularyEntityCopyWith<$Res> {
  factory _$VocabularyEntityCopyWith(_VocabularyEntity value, $Res Function(_VocabularyEntity) _then) = __$VocabularyEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String question, List<String> choices, String correctAnswer, String createdAt, String updatedAt
});




}
/// @nodoc
class __$VocabularyEntityCopyWithImpl<$Res>
    implements _$VocabularyEntityCopyWith<$Res> {
  __$VocabularyEntityCopyWithImpl(this._self, this._then);

  final _VocabularyEntity _self;
  final $Res Function(_VocabularyEntity) _then;

/// Create a copy of VocabularyEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? choices = null,Object? correctAnswer = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_VocabularyEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>,correctAnswer: null == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
