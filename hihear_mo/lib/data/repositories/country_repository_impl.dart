import 'package:dartz/dartz.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:hihear_mo/data/datasources/auth_remote_data_source.dart';
import 'package:hihear_mo/data/models/countryModel.dart';
import 'package:hihear_mo/domain/entities/country/country_entity.dart';
import 'package:hihear_mo/domain/entities/user/user_entity.dart';
import 'package:hihear_mo/domain/repositories/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final List<CountryModel> _countries = [
    CountryModel(name: 'United Kingdom', code: 'UK', flag: '🇬🇧', api: 'UNITEDKINGDOM'),
    CountryModel(name: 'Korea', code: 'Korea', flag: '🇰🇷', api: 'KOREAN'),
  ];

  final AuthRemoteDataSource dataSource;
  CountryRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, UserEntity>> addCountry(CountryEntity country) async {
    try {
      final user = await dataSource.addOrUpdateCountry(country);
      return Right(user);
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
