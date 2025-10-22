import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, dynamic>> loginWithFacebook() async {
    try{
      final data = await dataSource.loginWithFacebook();
      return Right(data);
    }catch(e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> loginWithGoogle() async {
    try {
      final data = await dataSource.loginWithFacebook();
      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

}