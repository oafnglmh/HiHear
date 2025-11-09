import { Uuid } from 'src/common/types';
import { LessionEntity } from '../entities/lession.entity';
import _ from 'lodash';
import { LessonCategory } from 'src/utils/lesson-category.enum';
import { Exercise } from 'src/modules/exercise/domain/exercise.domain';
import { Media } from 'src/modules/media/domain/media.domain';

export class Lession {
  id: Uuid;

  title: string;

  description: string | null;

  category: LessonCategory;

  level: string | null;

  durationSeconds: number;

  xpReward: number | null;

  prerequisiteLesson: Lession | null;

  media: Media[];

  exercise: Exercise[];

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(lessionEntity: LessionEntity): Lession {
    return {
      id: lessionEntity.id,
      title: lessionEntity.title,
      description: lessionEntity.description,
      category: lessionEntity.category,
      durationSeconds: lessionEntity.durationSeconds,
      xpReward: lessionEntity.xpReward,
      level: lessionEntity.level,
      prerequisiteLesson: lessionEntity.prerequisiteLesson
        ? Lession.fromEntity(lessionEntity.prerequisiteLesson)
        : null,
      media: Media.fromEntities(lessionEntity.media),
      exercise: Exercise.fromEntities(lessionEntity.exercises),
      createdAt: lessionEntity.createdAt,
      updatedAt: lessionEntity.updatedAt,
    };
  }

  static fromEntities(entities: LessionEntity[]): Lession[] {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
    return _.map(entities, (e) => Lession.fromEntity(e)) as Lession[];
  }
}
