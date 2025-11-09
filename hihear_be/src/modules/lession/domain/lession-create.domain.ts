import { Uuid } from 'src/common/types';
import { LessionCreateDto } from '../dto/lession-create.dto';
import { LessonCategory } from 'src/utils/lesson-category.enum';
import { MediaCreate } from 'src/modules/media/domain/media-create.domain';
import { ExerciseCreate } from 'src/modules/exercise/domain/exercise-create.domain';

export class LessionCreate {
  title: string;

  description: string | null;

  category: LessonCategory;

  level: string | null;

  durationSeconds: number | null;

  xpReward: number | null;

  prerequisiteLesson: Uuid | null;

  media?: MediaCreate[];

  exercises?: ExerciseCreate[];

  static toEntity(lessionCreate: LessionCreate): Partial<LessionCreateDto> {
    return {
      title: lessionCreate.title,
      category: lessionCreate.category,
      description: lessionCreate.description,
      durationSeconds: lessionCreate.durationSeconds,
      level: lessionCreate.level,
      prerequisiteLesson: lessionCreate.prerequisiteLesson,
      xpReward: lessionCreate.xpReward,
    };
  }
}
