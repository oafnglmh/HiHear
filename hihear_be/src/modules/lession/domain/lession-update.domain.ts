import { Uuid } from 'src/common/types';
import { LessionUpdateDto } from '../dto/lession-update.dto';

export class LessionUpdate {
  title?: string;

  description?: string;

  category?: string;

  level?: string;

  durationSeconds?: number;

  xpReward?: number;

  prerequisiteLesson?: Uuid;

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
