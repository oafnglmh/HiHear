import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/domain/entities/country_entity.dart';
import 'package:hihear_mo/domain/repositories/country_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_bloc.freezed.dart';
part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository _repository;
  final List<CountryEntity> _countries = [];
  CountryBloc(this._repository) : super(const CountryState.initial()) {
    on<_AddOrUpdateCountry>(_onAddOrUpdateCountry);
    on<_LoadCountries>(_onLoadCountries);
    on<_Search>(_onSearch);
  }

  Future<void> _onLoadCountries(
      _LoadCountries event, Emitter<CountryState> emit) async {
    emit(const CountryState.loading());
    try {
      final result = await _repository.loadCountries();
      result.fold(
        (failure) => emit(CountryState.error(failure.message)),
        (result) => emit(CountryState.data(result)),
      );
    } catch (e, s) {
      emit(CountryState.error('Login with Google failed: $e'));
      addError(e, s);
    }
  }
  Future<void> _onAddOrUpdateCountry(
      _AddOrUpdateCountry event, Emitter<CountryState> emit) async {
    emit(const CountryState.loading());
    try{
      final result = await _repository.addCountry(event.countryEntity);
      result.fold(
        (failure) => emit(CountryState.error(failure.message)),
        (result) => emit(CountryState.success()),
      );
    }
    catch (e, s) {
      emit(CountryState.error('Add Failer: $e'));
      addError(e, s);
    }
  }

  Future<void> _onSearch(
      _Search event, Emitter<CountryState> emit) async {
    final keyword = event.keyword.toLowerCase();

    final filtered = _countries.where((c) {
      return c.name.toLowerCase().contains(keyword) ||
              c.code.toLowerCase().contains(keyword);
    }).toList();

    emit(CountryState.filtered(filtered));
  }
  
}
