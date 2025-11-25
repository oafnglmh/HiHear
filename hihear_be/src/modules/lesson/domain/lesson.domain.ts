import { Uuid } from 'src/common/types';
import { LessonEntity } from '../entities/lesson.entity';
import _ from 'lodash';
import { Media } from 'src/modules/media/domain/media';
import { Exercises } from 'src/modules/exercises/domain/exercises.domain';

export class Lesson {
  id: Uuid;

  title: string;

  description: string | null;

  category: string | null;

  level: string | null;

  durationSeconds: number;

  xpReward: number | null;

  // prerequisiteLesson: Lesson | null;
  prerequisiteLessonId: string | null;

  media: Media[] | null;

  exercises: Exercises[] | null;

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
      prerequisiteLessonId: lessonEntity.prerequisiteLesson?.id ?? null,
      media: Media.fromEntities(lessonEntity.media),
      exercises: lessonEntity.exercises
        ? Exercises.fromEntities(lessonEntity.exercises)
        : [],
      createdAt: lessonEntity.createdAt,
      updatedAt: lessonEntity.updatedAt,
    };
  }

  static fromEntities(entities: LessonEntity[]): Lesson[] {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
    return _.map(entities, (e) => Lesson.fromEntity(e)) as Lesson[];
  }
}
