import { Uuid } from 'src/common/types';
import { LessionCreateDto } from '../dto/lession-create.dto';

export class LessionCreate {
  title: string;

  description: string | null;

  category: string | null;

  level: string | null;

  durationSeconds: number | null;

  xpReward: number | null;

  prerequisiteLesson: Uuid | null;

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
