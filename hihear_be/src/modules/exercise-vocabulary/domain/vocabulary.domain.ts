import { Uuid } from 'src/common/types';
import { VocabularyEntity } from '../entities/vocabulary.entity';

export class Vocabulary {
  id: Uuid;

  question: string;

  choices: string[];

  correctAnswer: string;

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(entity: VocabularyEntity): Vocabulary {
    return {
      id: entity.id,
      question: entity.question,
      choices: entity.choices,
      correctAnswer: entity.correctAnswer,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }

  static fromEntities(entities: VocabularyEntity[]): Vocabulary[] {
    return entities.map((e) => this.fromEntity(e));
  }
}
