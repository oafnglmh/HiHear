import { GrammarEntity } from '../entities/grammar.entity';

export class GrammarCreate {
  grammarRule: string;

  example: string;

  meaning: string;

  static toEntity(domain: GrammarCreate): Partial<GrammarEntity> {
    return {
      grammarRule: domain.grammarRule,
      example: domain.example,
      meaning: domain.meaning,
    };
  }
}
