import 'package:dartz/dartz.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:hihear_mo/data/datasources/auth_remote_data_source.dart';
import 'package:hihear_mo/data/models/countryModel.dart';
import 'package:hihear_mo/domain/entities/country_entity.dart';
import 'package:hihear_mo/domain/entities/user_entity.dart';
import 'package:hihear_mo/domain/repositories/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final List<CountryModel> _countries = [
    CountryModel(name: 'United States', code: 'us', flag: '🇺🇸', api: 'UNITEDSTATES'),
    CountryModel(name: 'United Kingdom', code: 'gb', flag: '🇬🇧', api: 'UNITEDKINGDOM'),
    CountryModel(name: 'Japan', code: 'jp', flag: '🇯🇵', api: 'JAPAN'),
    CountryModel(name: 'Korea', code: 'ko', flag: '🇰🇷', api: 'KOREAN'),
    CountryModel(name: 'China', code: 'cn', flag: '🇨🇳', api: 'CHINA'),
    CountryModel(name: 'Thailand', code: 'th', flag: '🇹🇭', api: 'THAILAND'),
    CountryModel(name: 'Singapore', code: 'sg', flag: '🇸🇬', api: 'SINGAPORE'),
    CountryModel(name: 'Malaysia', code: 'my', flag: '🇲🇾', api: 'MALAYSIA'),
    CountryModel(name: 'Indonesia', code: 'id', flag: '🇮🇩', api: 'INDONESIA'),
    CountryModel(name: 'Philippines', code: 'ph', flag: '🇵🇭', api: 'PHILIPPINES'),
    CountryModel(name: 'Australia', code: 'au', flag: '🇦🇺', api: 'AUSTRALIA'),
    CountryModel(name: 'Canada', code: 'ca', flag: '🇨🇦', api: 'CANADA'),
    CountryModel(name: 'Germany', code: 'de', flag: '🇩🇪', api: 'GERMANY'),
    CountryModel(name: 'France', code: 'fr', flag: '🇫🇷', api: 'FRANCE'),
    CountryModel(name: 'Italy', code: 'it', flag: '🇮🇹', api: 'ITALY'),
    CountryModel(name: 'Spain', code: 'es', flag: '🇪🇸', api: 'SPAIN'),
    CountryModel(name: 'Brazil', code: 'br', flag: '🇧🇷', api: 'BRAZIL'),
    CountryModel(name: 'Mexico', code: 'mx', flag: '🇲🇽', api: 'MEXICO'),
    CountryModel(name: 'India', code: 'in', flag: '🇮🇳', api: 'INDIA'),
  ];

  final AuthRemoteDataSource dataSource;
  CountryRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, UserEntity>> addCountry(CountryEntity country) async {
    try {
      final user = await dataSource.addOrUpdateCountry(country);
      return Right(user);      // user là UserEntity
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, List<CountryEntity>>> loadCountries() async {
    try {
      final result = _countries
          .map((e) => CountryEntity(name: e.name, code: e.code, flag: e.flag,api:e.api))
          .toList();

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
