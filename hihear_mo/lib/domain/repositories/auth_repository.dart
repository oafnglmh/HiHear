import 'package:dartz/dartz.dart';
abstract class AuthRepository{
  Future<Either<Failure,dynamic>> loginWithGoogle();
  Future<Either<Failure, dynamic>> loginWithFacebook();
}
class Failure {
  final String message;
  Failure(this.message);
}