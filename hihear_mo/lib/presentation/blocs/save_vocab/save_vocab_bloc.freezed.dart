// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_vocab_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SaveVocabEvent {

 String get id;
/// Create a copy of SaveVocabEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveVocabEventCopyWith<SaveVocabEvent> get copyWith => _$SaveVocabEventCopyWithImpl<SaveVocabEvent>(this as SaveVocabEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveVocabEvent&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'SaveVocabEvent(id: $id)';
}


}

/// @nodoc
abstract mixin class $SaveVocabEventCopyWith<$Res>  {
  factory $SaveVocabEventCopyWith(SaveVocabEvent value, $Res Function(SaveVocabEvent) _then) = _$SaveVocabEventCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$SaveVocabEventCopyWithImpl<$Res>
    implements $SaveVocabEventCopyWith<$Res> {
  _$SaveVocabEventCopyWithImpl(this._self, this._then);

  final SaveVocabEvent _self;
  final $Res Function(SaveVocabEvent) _then;

/// Create a copy of SaveVocabEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SaveVocabEvent].
extension SaveVocabEventPatterns on SaveVocabEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadVocabUserById value)?  loadVocabUserById,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadVocabUserById() when loadVocabUserById != null:
return loadVocabUserById(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadVocabUserById value)  loadVocabUserById,}){
final _that = this;
switch (_that) {
case _LoadVocabUserById():
return loadVocabUserById(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadVocabUserById value)?  loadVocabUserById,}){
final _that = this;
switch (_that) {
case _LoadVocabUserById() when loadVocabUserById != null:
return loadVocabUserById(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id)?  loadVocabUserById,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadVocabUserById() when loadVocabUserById != null:
return loadVocabUserById(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id)  loadVocabUserById,}) {final _that = this;
switch (_that) {
case _LoadVocabUserById():
return loadVocabUserById(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id)?  loadVocabUserById,}) {final _that = this;
switch (_that) {
case _LoadVocabUserById() when loadVocabUserById != null:
return loadVocabUserById(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _LoadVocabUserById implements SaveVocabEvent {
  const _LoadVocabUserById({required this.id});
  

@override final  String id;

/// Create a copy of SaveVocabEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadVocabUserByIdCopyWith<_LoadVocabUserById> get copyWith => __$LoadVocabUserByIdCopyWithImpl<_LoadVocabUserById>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadVocabUserById&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'SaveVocabEvent.loadVocabUserById(id: $id)';
}


}

/// @nodoc
abstract mixin class _$LoadVocabUserByIdCopyWith<$Res> implements $SaveVocabEventCopyWith<$Res> {
  factory _$LoadVocabUserByIdCopyWith(_LoadVocabUserById value, $Res Function(_LoadVocabUserById) _then) = __$LoadVocabUserByIdCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$LoadVocabUserByIdCopyWithImpl<$Res>
    implements _$LoadVocabUserByIdCopyWith<$Res> {
  __$LoadVocabUserByIdCopyWithImpl(this._self, this._then);

  final _LoadVocabUserById _self;
  final $Res Function(_LoadVocabUserById) _then;

/// Create a copy of SaveVocabEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_LoadVocabUserById(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SaveVocabState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveVocabState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SaveVocabState()';
}


}

/// @nodoc
class $SaveVocabStateCopyWith<$Res>  {
$SaveVocabStateCopyWith(SaveVocabState _, $Res Function(SaveVocabState) __);
}


/// Adds pattern-matching-related methods to [SaveVocabState].
extension SaveVocabStatePatterns on SaveVocabState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Error value)?  error,TResult Function( _VocabUserData value)?  vocabUserData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case _VocabUserData() when vocabUserData != null:
return vocabUserData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Error value)  error,required TResult Function( _VocabUserData value)  vocabUserData,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Error():
return error(_that);case _VocabUserData():
return vocabUserData(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Error value)?  error,TResult? Function( _VocabUserData value)?  vocabUserData,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case _VocabUserData() when vocabUserData != null:
return vocabUserData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( List<VocabUserEntity> vocabUsers)?  vocabUserData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.message);case _VocabUserData() when vocabUserData != null:
return vocabUserData(_that.vocabUsers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( List<VocabUserEntity> vocabUsers)  vocabUserData,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Error():
return error(_that.message);case _VocabUserData():
return vocabUserData(_that.vocabUsers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( List<VocabUserEntity> vocabUsers)?  vocabUserData,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.message);case _VocabUserData() when vocabUserData != null:
return vocabUserData(_that.vocabUsers);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SaveVocabState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SaveVocabState.initial()';
}


}




/// @nodoc


class _Loading implements SaveVocabState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SaveVocabState.loading()';
}


}




/// @nodoc


class _Error implements SaveVocabState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of SaveVocabState
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
  return 'SaveVocabState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SaveVocabStateCopyWith<$Res> {
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

/// Create a copy of SaveVocabState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VocabUserData implements SaveVocabState {
  const _VocabUserData(final  List<VocabUserEntity> vocabUsers): _vocabUsers = vocabUsers;
  

 final  List<VocabUserEntity> _vocabUsers;
 List<VocabUserEntity> get vocabUsers {
  if (_vocabUsers is EqualUnmodifiableListView) return _vocabUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vocabUsers);
}


/// Create a copy of SaveVocabState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VocabUserDataCopyWith<_VocabUserData> get copyWith => __$VocabUserDataCopyWithImpl<_VocabUserData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VocabUserData&&const DeepCollectionEquality().equals(other._vocabUsers, _vocabUsers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vocabUsers));

@override
String toString() {
  return 'SaveVocabState.vocabUserData(vocabUsers: $vocabUsers)';
}


}

/// @nodoc
abstract mixin class _$VocabUserDataCopyWith<$Res> implements $SaveVocabStateCopyWith<$Res> {
  factory _$VocabUserDataCopyWith(_VocabUserData value, $Res Function(_VocabUserData) _then) = __$VocabUserDataCopyWithImpl;
@useResult
$Res call({
 List<VocabUserEntity> vocabUsers
});




}
/// @nodoc
class __$VocabUserDataCopyWithImpl<$Res>
    implements _$VocabUserDataCopyWith<$Res> {
  __$VocabUserDataCopyWithImpl(this._self, this._then);

  final _VocabUserData _self;
  final $Res Function(_VocabUserData) _then;

/// Create a copy of SaveVocabState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vocabUsers = null,}) {
  return _then(_VocabUserData(
null == vocabUsers ? _self._vocabUsers : vocabUsers // ignore: cast_nullable_to_non_nullable
as List<VocabUserEntity>,
  ));
}


}

// dart format on
