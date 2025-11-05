part of 'country_bloc.dart';

@freezed
class CountryState with _$CountryState {
  const factory CountryState.initial() = _Initial;
  const factory CountryState.loading() = _Loading;
  const factory CountryState.success() = _Success;
  const factory CountryState.data(List<CountryEntity> countries) = _Data;
  const factory CountryState.filtered(List<CountryEntity> filtered) = _Filtered;
  const factory CountryState.error(String message) = _Error;
}
