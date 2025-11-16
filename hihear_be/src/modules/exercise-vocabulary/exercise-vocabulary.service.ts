import { InjectRepository } from '@nestjs/typeorm';
import { VocabularyEntity } from './entities/vocabulary.entity';
import { Repository } from 'typeorm';
import { ExercisesEntity } from '../exercises/entities/exercises.entity';
import { Vocabulary } from './domain/vocabulary.domain';
import { VocabularyCreate } from './domain/vocabulary-create.domain';
import { QueryRunner } from 'typeorm';

export class VocabularyService {
  constructor(
    @InjectRepository(VocabularyEntity)
    private readonly vocabularyRepository: Repository<VocabularyEntity>,
  ) {}

  async createMany(
    queryRunner: QueryRunner,
    exercise: ExercisesEntity,
    vocabularies: VocabularyCreate[],
  ): Promise<Vocabulary[]> {
    if (!vocabularies?.length) {
      return [];
    }

    const entities: VocabularyEntity[] = [];
    for (const vocab of vocabularies) {
      const entity = queryRunner.manager.create(VocabularyEntity, {
        exercise,
        ...VocabularyCreate.toEntity(vocab),
      });
      const saved = await queryRunner.manager.save(entity);
      entities.push(saved);
    }

    return Vocabulary.fromEntities(entities);
  }
}
