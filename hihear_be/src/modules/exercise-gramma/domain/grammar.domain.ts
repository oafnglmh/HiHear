import { Uuid } from 'src/common/types';
import { GrammarEntity } from '../entities/grammar.entity';

export class Grammar {
  id: Uuid;

  grammarRule: string;

  example: string;

  meaning: string;

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(entity: GrammarEntity): Grammar {
    return {
      id: entity.id,
      grammarRule: entity.grammarRule,
      example: entity.example,
      meaning: entity.meaning,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }

  static fromEntities(entities: GrammarEntity[]): Grammar[] {
    return entities.map((d) => this.fromEntity(d));
  }
}
