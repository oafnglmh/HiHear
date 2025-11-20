import 'package:dartz/dartz.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';

abstract class LessonRepository {
  Future<Either<Failure, List<LessionEntity>>> loadLessions();

  Future<Either<Failure, LessionEntity>> getLessonById(String id);
}
