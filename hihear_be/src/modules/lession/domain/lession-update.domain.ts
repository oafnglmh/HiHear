import { Uuid } from 'src/common/types';
import { LessionUpdateDto } from '../dto/lession-update.dto';
import { LessonCategory } from 'src/utils/lesson-category.enum';
import { MediaCreate } from 'src/modules/media/domain/media-create.domain';
import { Exercise } from 'src/modules/exercise/domain/exercise.domain';

export class LessionUpdate {
  title?: string;

  description?: string;

  category?: LessonCategory;

  level?: string;

  durationSeconds?: number;

  xpReward?: number;

  prerequisiteLesson?: Uuid;

  media?: MediaCreate[];

  exercise?: Exercise[];

  static toEntity(lessionUpdate: LessionUpdate): Partial<LessionUpdateDto> {
    return {
      title: lessionUpdate.title,
      category: lessionUpdate.category,
      description: lessionUpdate.description,
      durationSeconds: lessionUpdate.durationSeconds,
      level: lessionUpdate.level,
      xpReward: lessionUpdate.xpReward,
      prerequisiteLesson: lessionUpdate.prerequisiteLesson,
    };
  }
}
