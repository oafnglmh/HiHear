// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LessonEvent()';
}


}

/// @nodoc
class $LessonEventCopyWith<$Res>  {
$LessonEventCopyWith(LessonEvent _, $Res Function(LessonEvent) __);
}


/// Adds pattern-matching-related methods to [LessonEvent].
extension LessonEventPatterns on LessonEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadLesson value)?  loadLesson,TResult Function( _LoadLessonBySpeak value)?  loadLessonBySpeak,TResult Function( _LoadLessonById value)?  loadLessonById,TResult Function( _SaveVocabulary value)?  saveVocabulary,TResult Function( _SaveCompleteLesson value)?  saveCompleteLesson,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadLesson() when loadLesson != null:
return loadLesson(_that);case _LoadLessonBySpeak() when loadLessonBySpeak != null:
return loadLessonBySpeak(_that);case _LoadLessonById() when loadLessonById != null:
return loadLessonById(_that);case _SaveVocabulary() when saveVocabulary != null:
return saveVocabulary(_that);case _SaveCompleteLesson() when saveCompleteLesson != null:
return saveCompleteLesson(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadLesson value)  loadLesson,required TResult Function( _LoadLessonBySpeak value)  loadLessonBySpeak,required TResult Function( _LoadLessonById value)  loadLessonById,required TResult Function( _SaveVocabulary value)  saveVocabulary,required TResult Function( _SaveCompleteLesson value)  saveCompleteLesson,}){
final _that = this;
switch (_that) {
case _LoadLesson():
return loadLesson(_that);case _LoadLessonBySpeak():
return loadLessonBySpeak(_that);case _LoadLessonById():
return loadLessonById(_that);case _SaveVocabulary():
return saveVocabulary(_that);case _SaveCompleteLesson():
return saveCompleteLesson(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadLesson value)?  loadLesson,TResult? Function( _LoadLessonBySpeak value)?  loadLessonBySpeak,TResult? Function( _LoadLessonById value)?  loadLessonById,TResult? Function( _SaveVocabulary value)?  saveVocabulary,TResult? Function( _SaveCompleteLesson value)?  saveCompleteLesson,}){
final _that = this;
switch (_that) {
case _LoadLesson() when loadLesson != null:
return loadLesson(_that);case _LoadLessonBySpeak() when loadLessonBySpeak != null:
return loadLessonBySpeak(_that);case _LoadLessonById() when loadLessonById != null:
return loadLessonById(_that);case _SaveVocabulary() when saveVocabulary != null:
return saveVocabulary(_that);case _SaveCompleteLesson() when saveCompleteLesson != null:
return saveCompleteLesson(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadLesson,TResult Function()?  loadLessonBySpeak,TResult Function( String id)?  loadLessonById,TResult Function( String word,  String meaning,  String category,  String userId)?  saveVocabulary,TResult Function( String lessonId,  String userId)?  saveCompleteLesson,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadLesson() when loadLesson != null:
return loadLesson();case _LoadLessonBySpeak() when loadLessonBySpeak != null:
return loadLessonBySpeak();case _LoadLessonById() when loadLessonById != null:
return loadLessonById(_that.id);case _SaveVocabulary() when saveVocabulary != null:
return saveVocabulary(_that.word,_that.meaning,_that.category,_that.userId);case _SaveCompleteLesson() when saveCompleteLesson != null:
return saveCompleteLesson(_that.lessonId,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadLesson,required TResult Function()  loadLessonBySpeak,required TResult Function( String id)  loadLessonById,required TResult Function( String word,  String meaning,  String category,  String userId)  saveVocabulary,required TResult Function( String lessonId,  String userId)  saveCompleteLesson,}) {final _that = this;
switch (_that) {
case _LoadLesson():
return loadLesson();case _LoadLessonBySpeak():
return loadLessonBySpeak();case _LoadLessonById():
return loadLessonById(_that.id);case _SaveVocabulary():
return saveVocabulary(_that.word,_that.meaning,_that.category,_that.userId);case _SaveCompleteLesson():
return saveCompleteLesson(_that.lessonId,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadLesson,TResult? Function()?  loadLessonBySpeak,TResult? Function( String id)?  loadLessonById,TResult? Function( String word,  String meaning,  String category,  String userId)?  saveVocabulary,TResult? Function( String lessonId,  String userId)?  saveCompleteLesson,}) {final _that = this;
switch (_that) {
case _LoadLesson() when loadLesson != null:
return loadLesson();case _LoadLessonBySpeak() when loadLessonBySpeak != null:
return loadLessonBySpeak();case _LoadLessonById() when loadLessonById != null:
return loadLessonById(_that.id);case _SaveVocabulary() when saveVocabulary != null:
return saveVocabulary(_that.word,_that.meaning,_that.category,_that.userId);case _SaveCompleteLesson() when saveCompleteLesson != null:
return saveCompleteLesson(_that.lessonId,_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _LoadLesson implements LessonEvent {
  const _LoadLesson();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadLesson);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LessonEvent.loadLesson()';
}


}




/// @nodoc


class _LoadLessonBySpeak implements LessonEvent {
  const _LoadLessonBySpeak();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadLessonBySpeak);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LessonEvent.loadLessonBySpeak()';
}


}




/// @nodoc


class _LoadLessonById implements LessonEvent {
  const _LoadLessonById(this.id);
  

 final  String id;

/// Create a copy of LessonEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadLessonByIdCopyWith<_LoadLessonById> get copyWith => __$LoadLessonByIdCopyWithImpl<_LoadLessonById>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadLessonById&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'LessonEvent.loadLessonById(id: $id)';
}


}

/// @nodoc
abstract mixin class _$LoadLessonByIdCopyWith<$Res> implements $LessonEventCopyWith<$Res> {
  factory _$LoadLessonByIdCopyWith(_LoadLessonById value, $Res Function(_LoadLessonById) _then) = __$LoadLessonByIdCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$LoadLessonByIdCopyWithImpl<$Res>
    implements _$LoadLessonByIdCopyWith<$Res> {
  __$LoadLessonByIdCopyWithImpl(this._self, this._then);

  final _LoadLessonById _self;
  final $Res Function(_LoadLessonById) _then;

/// Create a copy of LessonEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_LoadLessonById(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SaveVocabulary implements LessonEvent {
  const _SaveVocabulary({required this.word, required this.meaning, required this.category, required this.userId});
  

 final  String word;
 final  String meaning;
 final  String category;
 final  String userId;

/// Create a copy of LessonEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveVocabularyCopyWith<_SaveVocabulary> get copyWith => __$SaveVocabularyCopyWithImpl<_SaveVocabulary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveVocabulary&&(identical(other.word, word) || other.word == word)&&(identical(other.meaning, meaning) || other.meaning == meaning)&&(identical(other.category, category) || other.category == category)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,word,meaning,category,userId);

@override
String toString() {
  return 'LessonEvent.saveVocabulary(word: $word, meaning: $meaning, category: $category, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$SaveVocabularyCopyWith<$Res> implements $LessonEventCopyWith<$Res> {
  factory _$SaveVocabularyCopyWith(_SaveVocabulary value, $Res Function(_SaveVocabulary) _then) = __$SaveVocabularyCopyWithImpl;
@useResult
$Res call({
 String word, String meaning, String category, String userId
});




}
/// @nodoc
class __$SaveVocabularyCopyWithImpl<$Res>
    implements _$SaveVocabularyCopyWith<$Res> {
  __$SaveVocabularyCopyWithImpl(this._self, this._then);

  final _SaveVocabulary _self;
  final $Res Function(_SaveVocabulary) _then;

/// Create a copy of LessonEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? word = null,Object? meaning = null,Object? category = null,Object? userId = null,}) {
  return _then(_SaveVocabulary(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SaveCompleteLesson implements LessonEvent {
  const _SaveCompleteLesson({required this.lessonId, required this.userId});
  

 final  String lessonId;
 final  String userId;

/// Create a copy of LessonEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveCompleteLessonCopyWith<_SaveCompleteLesson> get copyWith => __$SaveCompleteLessonCopyWithImpl<_SaveCompleteLesson>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveCompleteLesson&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,lessonId,userId);

@override
String toString() {
  return 'LessonEvent.saveCompleteLesson(lessonId: $lessonId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$SaveCompleteLessonCopyWith<$Res> implements $LessonEventCopyWith<$Res> {
  factory _$SaveCompleteLessonCopyWith(_SaveCompleteLesson value, $Res Function(_SaveCompleteLesson) _then) = __$SaveCompleteLessonCopyWithImpl;
@useResult
$Res call({
 String lessonId, String userId
});




}
/// @nodoc
class __$SaveCompleteLessonCopyWithImpl<$Res>
    implements _$SaveCompleteLessonCopyWith<$Res> {
  __$SaveCompleteLessonCopyWithImpl(this._self, this._then);

  final _SaveCompleteLesson _self;
  final $Res Function(_SaveCompleteLesson) _then;

/// Create a copy of LessonEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lessonId = null,Object? userId = null,}) {
  return _then(_SaveCompleteLesson(
lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LessonState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LessonState()';
}


}

/// @nodoc
class $LessonStateCopyWith<$Res>  {
$LessonStateCopyWith(LessonState _, $Res Function(LessonState) __);
}


/// Adds pattern-matching-related methods to [LessonState].
extension LessonStatePatterns on LessonState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Data value)?  data,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Data() when data != null:
return data(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Data value)  data,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Data():
return data(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Data value)?  data,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Data() when data != null:
return data(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<LessionEntity> lessons)?  data,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Data() when data != null:
return data(_that.lessons);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<LessionEntity> lessons)  data,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Data():
return data(_that.lessons);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<LessionEntity> lessons)?  data,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Data() when data != null:
return data(_that.lessons);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LessonState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LessonState.initial()';
}


}




/// @nodoc


class _Loading implements LessonState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LessonState.loading()';
}


}




/// @nodoc


class _Data implements LessonState {
  const _Data(final  List<LessionEntity> lessons): _lessons = lessons;
  

 final  List<LessionEntity> _lessons;
 List<LessionEntity> get lessons {
  if (_lessons is EqualUnmodifiableListView) return _lessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessons);
}


/// Create a copy of LessonState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataCopyWith<_Data> get copyWith => __$DataCopyWithImpl<_Data>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data&&const DeepCollectionEquality().equals(other._lessons, _lessons));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_lessons));

@override
String toString() {
  return 'LessonState.data(lessons: $lessons)';
}


}

/// @nodoc
abstract mixin class _$DataCopyWith<$Res> implements $LessonStateCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) _then) = __$DataCopyWithImpl;
@useResult
$Res call({
 List<LessionEntity> lessons
});




}
/// @nodoc
class __$DataCopyWithImpl<$Res>
    implements _$DataCopyWith<$Res> {
  __$DataCopyWithImpl(this._self, this._then);

  final _Data _self;
  final $Res Function(_Data) _then;

/// Create a copy of LessonState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lessons = null,}) {
  return _then(_Data(
null == lessons ? _self._lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessionEntity>,
  ));
}


}

/// @nodoc


class _Error implements LessonState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of LessonState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LessonState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $LessonStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of LessonState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
