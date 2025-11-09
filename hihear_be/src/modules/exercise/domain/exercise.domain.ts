import { ExerciseEntity } from '../entities/exercise.entity';
import { ExerciseType } from 'src/utils/exercise-type.enum';
import { VocabularyContent } from './vocabulary-content.domain';
import { GrammarContent } from './gramma-content.domain';
import { ListeningContent } from './listening-content.domain';
import { SpeakingContent } from './speaking-content.domain';
import { Lession } from 'src/modules/lession/domain/lession.domain';
import { Uuid } from 'src/common/types';

export class Exercise {
  id: Uuid;

  lesson: Lession;

  type: ExerciseType;

  content: VocabularyContent | GrammarContent | ListeningContent | SpeakingContent;

  points: number;

  aiFeedback: string;

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(entity: ExerciseEntity): Exercise {
    return {
      id: entity.id,
      lesson: Lession.fromEntity(entity.lesson),
      type: entity.type,
      content: entity.content,
      points: entity.points,
      aiFeedback: entity.aiFeedback,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }

  static fromEntities(entities: ExerciseEntity[]): Exercise[] {
    return entities.map((e) => Exercise.fromEntity(e));
  }
}
