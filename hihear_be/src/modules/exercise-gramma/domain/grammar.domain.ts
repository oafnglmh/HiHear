import { Uuid } from 'src/common/types';

export class Grammar {
  id: Uuid;

  grammarRule: string;

  example: string;

  meaning: string;

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(entity: Grammar): Grammar {
    return {
      id: entity.id,
      grammarRule: entity.grammarRule,
      example: entity.example,
      meaning: entity.meaning,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }

  static fromEntities(entities: Grammar[]): Grammar[] {
    return entities.map((d) => this.fromEntity(d));
  }
}
