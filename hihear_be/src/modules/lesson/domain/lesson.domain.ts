import { Uuid } from 'src/common/types';
import { LessonEntity } from '../entities/lesson.entity';
import _ from 'lodash';
import { Media } from 'src/modules/media/domain/media';

export class Lesson {
  id: Uuid;

  title: string;

  description: string | null;

  category: string | null;

  level: string | null;

  durationSeconds: number;

  xpReward: number | null;

  prerequisiteLesson: Lesson | null;

  media: Media[] | null;

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(lessonEntity: LessonEntity): Lesson {
    return {
      id: lessonEntity.id,
      title: lessonEntity.title,
      description: lessonEntity.description,
      category: lessonEntity.category,
      durationSeconds: lessonEntity.durationSeconds,
      xpReward: lessonEntity.xpReward,
      level: lessonEntity.level,
      prerequisiteLesson: lessonEntity.prerequisiteLesson
        ? Lesson.fromEntity(lessonEntity.prerequisiteLesson)
        : null,
      media: Media.fromEntities(lessonEntity.media),
      createdAt: lessonEntity.createdAt,
      updatedAt: lessonEntity.updatedAt,
    };
  }

  static fromEntities(entities: LessonEntity[]): Lesson[] {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
    return _.map(entities, (e) => Lesson.fromEntity(e)) as Lesson[];
  }
}
