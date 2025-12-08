import 'package:dartz/dartz.dart';
import 'package:hihear_mo/core/error/failures.dart';
import 'package:hihear_mo/data/datasources/auth_remote_data_source.dart';
import 'package:hihear_mo/data/datasources/lession_remote_date_source.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/domain/repositories/lession_repository.dart';

class LessionRepositoryImpl implements LessonRepository {
  final LessionRemoteDataSource dataSource;

  LessionRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<LessionEntity>>> loadLessions() async {
    try {
      final lessons = await dataSource.loadLessions();
      return Right(lessons);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LessionEntity>> getLessonById(String id) async {
    try {
      final lesson = await dataSource.loadLessionById(id);
      return Right(lesson);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveVocabulary({
    required String word,
    required String meaning,
    required String category,
    required String userId,
  }) async {
    try {
      final lesson = await dataSource.saveVocabulary(
        word: word,
        meaning: meaning,
        category: category,
        userId: userId,
      );
      return Right(lesson);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveCompleteLesson({
    required String lessonId,
    required String userId,
  }) async {
    try {
      await dataSource.saveCompleteLesson(lessonId: lessonId, userId: userId);

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
