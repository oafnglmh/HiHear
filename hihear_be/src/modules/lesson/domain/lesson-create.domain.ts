import { Uuid } from 'src/common/types';
import { LessonCreateDto } from '../dto/lesson-create.dto';

export class LessonCreate {
  title: string;

  description: string | null;

  category: string | null;

  level: string | null;

  durationSeconds: number | null;

  xpReward: number | null;

  prerequisiteLesson: Uuid | null;

  mediaId?: Uuid | null;

  static toEntity(lessonCreate: LessonCreate): Partial<LessonCreateDto> {
    return {
      title: lessonCreate.title,
      category: lessonCreate.category,
      description: lessonCreate.description,
      durationSeconds: lessonCreate.durationSeconds,
      level: lessonCreate.level,
      prerequisiteLesson: lessonCreate.prerequisiteLesson,
      xpReward: lessonCreate.xpReward,
    };
  }
}
