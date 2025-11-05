// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CountryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CountryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryEvent()';
}


}

/// @nodoc
class $CountryEventCopyWith<$Res>  {
$CountryEventCopyWith(CountryEvent _, $Res Function(CountryEvent) __);
}


/// Adds pattern-matching-related methods to [CountryEvent].
extension CountryEventPatterns on CountryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _AddCountry value)?  addCountry,TResult Function( _LoadCountries value)?  loadCountries,TResult Function( _Search value)?  search,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddCountry() when addCountry != null:
return addCountry(_that);case _LoadCountries() when loadCountries != null:
return loadCountries(_that);case _Search() when search != null:
return search(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _AddCountry value)  addCountry,required TResult Function( _LoadCountries value)  loadCountries,required TResult Function( _Search value)  search,}){
final _that = this;
switch (_that) {
case _AddCountry():
return addCountry(_that);case _LoadCountries():
return loadCountries(_that);case _Search():
return search(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _AddCountry value)?  addCountry,TResult? Function( _LoadCountries value)?  loadCountries,TResult? Function( _Search value)?  search,}){
final _that = this;
switch (_that) {
case _AddCountry() when addCountry != null:
return addCountry(_that);case _LoadCountries() when loadCountries != null:
return loadCountries(_that);case _Search() when search != null:
return search(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  addCountry,TResult Function()?  loadCountries,TResult Function( String keyword)?  search,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddCountry() when addCountry != null:
return addCountry();case _LoadCountries() when loadCountries != null:
return loadCountries();case _Search() when search != null:
return search(_that.keyword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  addCountry,required TResult Function()  loadCountries,required TResult Function( String keyword)  search,}) {final _that = this;
switch (_that) {
case _AddCountry():
return addCountry();case _LoadCountries():
return loadCountries();case _Search():
return search(_that.keyword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  addCountry,TResult? Function()?  loadCountries,TResult? Function( String keyword)?  search,}) {final _that = this;
switch (_that) {
case _AddCountry() when addCountry != null:
return addCountry();case _LoadCountries() when loadCountries != null:
return loadCountries();case _Search() when search != null:
return search(_that.keyword);case _:
  return null;

}
}

}

/// @nodoc


class _AddCountry implements CountryEvent {
  const _AddCountry();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddCountry);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryEvent.addCountry()';
}


}




/// @nodoc


class _LoadCountries implements CountryEvent {
  const _LoadCountries();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadCountries);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryEvent.loadCountries()';
}


}




/// @nodoc


class _Search implements CountryEvent {
  const _Search(this.keyword);
  

 final  String keyword;

/// Create a copy of CountryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchCopyWith<_Search> get copyWith => __$SearchCopyWithImpl<_Search>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Search&&(identical(other.keyword, keyword) || other.keyword == keyword));
}


@override
int get hashCode => Object.hash(runtimeType,keyword);

@override
String toString() {
  return 'CountryEvent.search(keyword: $keyword)';
}


}

/// @nodoc
abstract mixin class _$SearchCopyWith<$Res> implements $CountryEventCopyWith<$Res> {
  factory _$SearchCopyWith(_Search value, $Res Function(_Search) _then) = __$SearchCopyWithImpl;
@useResult
$Res call({
 String keyword
});




}
/// @nodoc
class __$SearchCopyWithImpl<$Res>
    implements _$SearchCopyWith<$Res> {
  __$SearchCopyWithImpl(this._self, this._then);

  final _Search _self;
  final $Res Function(_Search) _then;

/// Create a copy of CountryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? keyword = null,}) {
  return _then(_Search(
null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CountryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CountryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryState()';
}


}

/// @nodoc
class $CountryStateCopyWith<$Res>  {
$CountryStateCopyWith(CountryState _, $Res Function(CountryState) __);
}


/// Adds pattern-matching-related methods to [CountryState].
extension CountryStatePatterns on CountryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Data value)?  data,TResult Function( _Filtered value)?  filtered,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Data() when data != null:
return data(_that);case _Filtered() when filtered != null:
return filtered(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Data value)  data,required TResult Function( _Filtered value)  filtered,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Data():
return data(_that);case _Filtered():
return filtered(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Data value)?  data,TResult? Function( _Filtered value)?  filtered,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Data() when data != null:
return data(_that);case _Filtered() when filtered != null:
return filtered(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( List<CountryEntity> countries)?  data,TResult Function( List<CountryEntity> filtered)?  filtered,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success();case _Data() when data != null:
return data(_that.countries);case _Filtered() when filtered != null:
return filtered(_that.filtered);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( List<CountryEntity> countries)  data,required TResult Function( List<CountryEntity> filtered)  filtered,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success();case _Data():
return data(_that.countries);case _Filtered():
return filtered(_that.filtered);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( List<CountryEntity> countries)?  data,TResult? Function( List<CountryEntity> filtered)?  filtered,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success();case _Data() when data != null:
return data(_that.countries);case _Filtered() when filtered != null:
return filtered(_that.filtered);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CountryState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryState.initial()';
}


}




/// @nodoc


class _Loading implements CountryState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryState.loading()';
}


}




/// @nodoc


class _Success implements CountryState {
  const _Success();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CountryState.success()';
}


}




/// @nodoc


class _Data implements CountryState {
  const _Data(final  List<CountryEntity> countries): _countries = countries;
  

 final  List<CountryEntity> _countries;
 List<CountryEntity> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}


/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataCopyWith<_Data> get copyWith => __$DataCopyWithImpl<_Data>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data&&const DeepCollectionEquality().equals(other._countries, _countries));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_countries));

@override
String toString() {
  return 'CountryState.data(countries: $countries)';
}


}

/// @nodoc
abstract mixin class _$DataCopyWith<$Res> implements $CountryStateCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) _then) = __$DataCopyWithImpl;
@useResult
$Res call({
 List<CountryEntity> countries
});




}
/// @nodoc
class __$DataCopyWithImpl<$Res>
    implements _$DataCopyWith<$Res> {
  __$DataCopyWithImpl(this._self, this._then);

  final _Data _self;
  final $Res Function(_Data) _then;

/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? countries = null,}) {
  return _then(_Data(
null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<CountryEntity>,
  ));
}


}

/// @nodoc


class _Filtered implements CountryState {
  const _Filtered(final  List<CountryEntity> filtered): _filtered = filtered;
  

 final  List<CountryEntity> _filtered;
 List<CountryEntity> get filtered {
  if (_filtered is EqualUnmodifiableListView) return _filtered;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filtered);
}


/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilteredCopyWith<_Filtered> get copyWith => __$FilteredCopyWithImpl<_Filtered>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Filtered&&const DeepCollectionEquality().equals(other._filtered, _filtered));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_filtered));

@override
String toString() {
  return 'CountryState.filtered(filtered: $filtered)';
}


}

/// @nodoc
abstract mixin class _$FilteredCopyWith<$Res> implements $CountryStateCopyWith<$Res> {
  factory _$FilteredCopyWith(_Filtered value, $Res Function(_Filtered) _then) = __$FilteredCopyWithImpl;
@useResult
$Res call({
 List<CountryEntity> filtered
});




}
/// @nodoc
class __$FilteredCopyWithImpl<$Res>
    implements _$FilteredCopyWith<$Res> {
  __$FilteredCopyWithImpl(this._self, this._then);

  final _Filtered _self;
  final $Res Function(_Filtered) _then;

/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filtered = null,}) {
  return _then(_Filtered(
null == filtered ? _self._filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<CountryEntity>,
  ));
}


}

/// @nodoc


class _Error implements CountryState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of CountryState
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
  return 'CountryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $CountryStateCopyWith<$Res> {
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

/// Create a copy of CountryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
