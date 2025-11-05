part of 'country_bloc.dart';

@freezed
class CountryEvent with _$CountryEvent {
  const factory CountryEvent.addCountry() = _AddCountry;
  const factory CountryEvent.loadCountries() = _LoadCountries;
  const factory CountryEvent.search(String keyword) = _Search;
}
