import { ExercisesEntity } from '../entities/exercises.entity';
import { ExerciseType } from 'src/utils/enums/exercise-type.enum';
import { Uuid } from 'src/common/types';
import { Nationality } from 'src/utils/enums/nationality.enum';
import { Vocabulary } from 'src/modules/exercise-vocabulary/domain/vocabulary.domain';

export class Exercises {
  id: Uuid;

  lessonId: string | null;

  type: ExerciseType;

  points: number;

  national: Nationality;

  vocabularies?: Vocabulary[];

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(entity: ExercisesEntity): Exercises {
    return {
      id: entity.id,
      lessonId: entity.lesson?.id ?? null,
      type: entity.type,
      points: entity.points,
      national: entity.national,
      vocabularies: entity.vocabularies
        ? Vocabulary.fromEntities(entity.vocabularies)
        : [],
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }

  static fromEntities(entities: ExercisesEntity[]): Exercises[] {
    return entities.map((e) => Exercises.fromEntity(e));
  }
}
