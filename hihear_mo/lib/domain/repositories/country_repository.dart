import 'package:dartz/dartz.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:hihear_mo/domain/entities/country_entity.dart';

abstract class CountryRepository {
  Future<Either<Failure, CountryEntity >> addCountry();
  Future<Either<Failure, List<CountryEntity>>> loadCountries();

}
