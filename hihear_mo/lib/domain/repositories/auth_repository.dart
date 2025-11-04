import 'package:dartz/dartz.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:hihear_mo/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> loginWithGoogle();
  Future<Either<Failure, UserEntity>> loginWithFacebook();
  Future<Either<Failure, Unit>> logout();
}
