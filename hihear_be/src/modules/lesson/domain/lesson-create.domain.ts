import { Uuid } from 'src/common/types';
import { LessonCreateDto } from '../dto/lesson-create.dto';
import { ExercisesCreate } from 'src/modules/exercises/domain/exercises-create.domain';
import { LessonCategory } from 'src/utils/enums/lesson-category.enum';
import { LessonVideoCreateDto } from 'src/modules/lesson-video/dto/lesson-video-create.dto';

export class LessonCreate {
  title: string;

  description: string | null;

  category: LessonCategory | null;

  level: string | null;

  durationSeconds: number | null;

  xpReward: number | null;

  prerequisiteLesson: Uuid | null;

  mediaId?: Uuid | null;

  exercises?: ExercisesCreate[];

  videoData?: LessonVideoCreateDto;
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
