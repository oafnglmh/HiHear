import { Uuid } from 'src/common/types';
import { ListeningEntity } from '../entities/listening.entity';
import { Media } from 'src/modules/media/domain/media';

export class Listening {
  id: Uuid;

  media: Media | null;

  transcript: string | null;

  choices: string[];

  correctAnswer: string;

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(entity: ListeningEntity): Listening {
    return {
      id: entity.id,
      media: entity.media ? Media.fromEntity(entity.media) : null,
      transcript: entity.transcript ?? null,
      choices: entity.choices,
      correctAnswer: entity.correctAnswer,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }

  static fromEntities(entities: ListeningEntity[]): Listening[] {
    return entities.map((e) => Listening.fromEntity(e));
  }
}
