import { VocabularyEntity } from '../entities/vocabulary.entity';

export class VocabularyCreate {
  question: string;

  choices: string[];

  correctAnswer: string;

  static toEntity(domain: VocabularyCreate): Partial<VocabularyEntity> {
    return {
      question: domain.question,
      choices: domain.choices,
      correctAnswer: domain.correctAnswer,
    };
  }
}
