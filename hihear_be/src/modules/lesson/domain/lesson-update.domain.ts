import { Uuid } from 'src/common/types';
import { LessonUpdateDto } from '../dto/lesson-update.dto';

export class LessonUpdate {
  title?: string;

  description?: string;

  category?: string;

  level?: string;

  durationSeconds?: number;

  xpReward?: number;

  prerequisiteLesson?: Uuid;

  static toEntity(lessonUpdate: LessonUpdate): Partial<LessonUpdateDto> {
    return {
      title: lessonUpdate.title,
      category: lessonUpdate.category,
      description: lessonUpdate.description,
      durationSeconds: lessonUpdate.durationSeconds,
      level: lessonUpdate.level,
      xpReward: lessonUpdate.xpReward,
      prerequisiteLesson: lessonUpdate.prerequisiteLesson,
    };
  }
}
