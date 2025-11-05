import 'package:dartz/dartz.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:hihear_mo/data/models/countryModel.dart';
import 'package:hihear_mo/domain/entities/country_entity.dart';
import 'package:hihear_mo/domain/repositories/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final List<CountryModel> _countries = [
    CountryModel(name: 'United States', code: 'US', flag: '🇺🇸'),
    CountryModel(name: 'United Kingdom', code: 'GB', flag: '🇬🇧'),
    CountryModel(name: 'Japan', code: 'JP', flag: '🇯🇵'),
    CountryModel(name: 'Korea', code: 'KR', flag: '🇰🇷'),
    CountryModel(name: 'China', code: 'CN', flag: '🇨🇳'),
    CountryModel(name: 'Thailand', code: 'TH', flag: '🇹🇭'),
    CountryModel(name: 'Singapore', code: 'SG', flag: '🇸🇬'),
    CountryModel(name: 'Malaysia', code: 'MY', flag: '🇲🇾'),
    CountryModel(name: 'Indonesia', code: 'ID', flag: '🇮🇩'),
    CountryModel(name: 'Philippines', code: 'PH', flag: '🇵🇭'),
    CountryModel(name: 'Australia', code: 'AU', flag: '🇦🇺'),
    CountryModel(name: 'Canada', code: 'CA', flag: '🇨🇦'),
    CountryModel(name: 'Germany', code: 'DE', flag: '🇩🇪'),
    CountryModel(name: 'France', code: 'FR', flag: '🇫🇷'),
    CountryModel(name: 'Italy', code: 'IT', flag: '🇮🇹'),
    CountryModel(name: 'Spain', code: 'ES', flag: '🇪🇸'),
    CountryModel(name: 'Brazil', code: 'BR', flag: '🇧🇷'),
    CountryModel(name: 'Mexico', code: 'MX', flag: '🇲🇽'),
    CountryModel(name: 'India', code: 'IN', flag: '🇮🇳'),
  ];
  @override
  Future<Either<Failure, CountryEntity>> addCountry() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CountryEntity>>> loadCountries() async {
    try {
      final result = _countries
          .map((e) => CountryEntity(name: e.name, code: e.code, flag: e.flag))
          .toList();

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
