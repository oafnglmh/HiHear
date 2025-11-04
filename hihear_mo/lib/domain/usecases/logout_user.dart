import 'package:dartz/dartz.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:hihear_mo/domain/repositories/auth_repository.dart';

class LogoutUser {
  final AuthRepository repository;
  LogoutUser(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }
}
