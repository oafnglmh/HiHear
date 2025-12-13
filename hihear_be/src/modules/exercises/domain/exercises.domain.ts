import { ExercisesEntity } from '../entities/exercises.entity';
import { ExerciseType } from 'src/utils/enums/exercise-type.enum';
import { Uuid } from 'src/common/types';
import { Nationality } from 'src/utils/enums/nationality.enum';
import { Vocabulary } from 'src/modules/exercise-vocabulary/domain/vocabulary.domain';
import { Grammar } from 'src/modules/exercise-gramma/domain/grammar.domain';
import { Listening } from 'src/modules/exercise-listening/domain/listening.domain';
import { Speaking } from 'src/modules/exercise-speaking/domain/speaking.domain';

export class Exercises {
  id: Uuid;

  lessonId: string | null;

  type: ExerciseType;

  points: number;

  national: Nationality;

  vocabularies?: Vocabulary[];

  grammars?: Grammar[];

  listenings?: Listening[];

  speakings? : Speaking[];

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
      grammars: entity.grammars ? Grammar.fromEntities(entity.grammars) : [],
      listenings: entity.listenings
        ? Listening.fromEntities(entity.listenings)
        : [],
      speakings: entity.speakings ? Speaking.fromEntities(entity.speakings) : [],
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }

  static fromEntities(entities: ExercisesEntity[]): Exercises[] {
    return entities.map((e) => Exercises.fromEntity(e));
  }
}
