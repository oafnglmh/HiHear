import { Uuid } from 'src/common/types';
import { LessionEntity } from '../entities/lession.entity';
import _ from 'lodash';

export class Lession {
  id: Uuid;

  title: string;

  description: string | null;

  category: string | null;

  level: string | null;

  durationSeconds: number;

  xpReward: number | null;

  prerequisiteLesson: Lession | null;

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
      createdAt: lessionEntity.createdAt,
      updatedAt: lessionEntity.updatedAt,
    };
  }

  static fromEntities(entities: LessionEntity[]): Lession[] {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
    return _.map(entities, (e) => Lession.fromEntity(e)) as Lession[];
  }
}
