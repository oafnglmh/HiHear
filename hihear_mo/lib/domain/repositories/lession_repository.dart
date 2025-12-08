import 'package:dartz/dartz.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';

abstract class LessonRepository {
  Future<Either<Failure, List<LessionEntity>>> loadLessions();

  Future<Either<Failure, LessionEntity>> getLessonById(String id);

  Future<Either<Failure, void>> saveVocabulary({
    required String word,
    required String meaning,
    required String category,
    required String userId,
  });

  Future<Either<Failure, void>> saveCompleteLesson({
    required String lessonId,
    required String userId,
  });
}
