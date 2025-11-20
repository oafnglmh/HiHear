import 'package:dartz/dartz.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:hihear_mo/domain/entities/country/country_entity.dart';
import 'package:hihear_mo/domain/entities/user/user_entity.dart';

abstract class CountryRepository {
  Future<Either<Failure, UserEntity >> addCountry(CountryEntity countryEntity);
  Future<Either<Failure, List<CountryEntity>>> loadCountries();

}
