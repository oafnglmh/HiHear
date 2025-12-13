import { Uuid } from 'src/common/types';
import { SpeakingEntity } from '../entities/speaking.entity';

export class Speaking {
  id: Uuid;

  number: string;

  read: string[];

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(entity: SpeakingEntity): Speaking {
    return {
      id: entity.id,
      number: entity.number,
      read: entity.read,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }

  static fromEntities(entities: SpeakingEntity[]): Speaking[] {
    return entities.map((d) => this.fromEntity(d));
  }
}
