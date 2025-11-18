import { InjectRepository } from '@nestjs/typeorm';
import { ExercisesEntity } from './entities/exercises.entity';
import { Repository } from 'typeorm';
import { ExercisesCreate } from './domain/exercises-create.domain';
import { Exercises } from './domain/exercises.domain';
import { LessonEntity } from '../lesson/entities/lesson.entity';
import { VocabularyService } from '../exercise-vocabulary/exercise-vocabulary.service';
import { LessonCategory } from 'src/utils/enums/lesson-category.enum';
import { QueryRunner } from 'typeorm';
import { VocabularyEntity } from '../exercise-vocabulary/entities/vocabulary.entity';
import { VocabularyCreate } from '../exercise-vocabulary/domain/vocabulary-create.domain';
import { Uuid } from 'src/common/types';
import { GrammarEntity } from '../exercise-gramma/entities/grammar.entity';
import { GrammarCreate } from '../exercise-gramma/domain/grammar-create.domain';
import { ListeningEntity } from '../exercise-listening/entities/listening.entity';
import { ListeningCreate } from '../exercise-listening/domain/listening-create.domain';
import { MediaService } from '../media/media.service';

export class ExerciseService {
  constructor(
    @InjectRepository(ExercisesEntity)
    private readonly exerciseRepository: Repository<ExercisesEntity>,
    private readonly vocabularyService: VocabularyService,
    private readonly mediaService: MediaService,
  ) {}

  private readonly handlers: Record<
    LessonCategory,
    (
      queryRunner: QueryRunner,
      exercise: ExercisesEntity,
      ex: ExercisesCreate,
    ) => Promise<void>
  > = {
    [LessonCategory.VOCABULARY]: async (qr, exercise, ex) => {
      if (ex.vocabularies?.length) {
        exercise.vocabularies = ex.vocabularies.map((vocab) =>
          qr.manager.create(VocabularyEntity, VocabularyCreate.toEntity(vocab)),
        );
        return Promise.resolve();
      }
    },
    [LessonCategory.GRAMMAR]: async (qr, exercise, ex) => {
      if (ex.grammars?.length) {
        exercise.grammars = ex.grammars.map((grammar) =>
          qr.manager.create(GrammarEntity, GrammarCreate.toEntity(grammar)),
        );
        return Promise.resolve();
      }
    },
    [LessonCategory.LISTENING]: async (qr, exercise, ex) => {
      if (ex.listenings?.length) {
        exercise.listenings = await Promise.all(
          ex.listenings.map(async (listening) => {
            const listeningEntity = qr.manager.create(ListeningEntity, {
              ...ListeningCreate.toEntity(listening),
            });

            if (listening.mediaId) {
              const media = await this.mediaService.assignMediaToListening(
                listening.mediaId,
                listeningEntity,
              );

              listeningEntity.media = media;
            }

            return listeningEntity;
          }),
        );
      }

      return Promise.resolve();
    },
    [LessonCategory.SPEAKING]: async () => {},
    [LessonCategory.READING]: async () => {},
    [LessonCategory.WRITING]: async () => {},
  };

  private readonly lessonRelations = ['vocabularies', 'lesson'];

  async createExerciseToLesson(
    queryRunner: QueryRunner,
    lesson: LessonEntity,
    exerciseCreate: ExercisesCreate[],
  ): Promise<Exercises[]> {
    const exercises: ExercisesEntity[] = [];

    for (const ex of exerciseCreate) {
      const exercise = queryRunner.manager.create(ExercisesEntity, {
        ...ExercisesCreate.toEntity(ex),
        lesson: lesson.category === LessonCategory.SPEAKING ? null : lesson,
      });

      const handler = this.handlers[lesson.category];

      if (handler) {
        await handler(queryRunner, exercise, ex);
      }
      exercises.push(exercise);
    }

    return Exercises.fromEntities(exercises);
  }

  async findAll(): Promise<Exercises[]> {
    const exercises = await this.exerciseRepository.find({
      relations: this.lessonRelations,
      order: { createdAt: 'ASC' },
    });

    return Exercises.fromEntities(exercises);
  }

  async findOne(id: Uuid): Promise<Exercises> {
    const exercise = await this.getExerciseOrThrow(id);

    return Exercises.fromEntity(exercise);
  }

  private async getExerciseOrThrow(id: Uuid): Promise<ExercisesEntity> {
    const exercise = await this.exerciseRepository.findOne({
      where: { id },
      relations: this.lessonRelations,
    });
    if (!exercise) {
      throw new Error(`Exercise with id ${id} not found`);
    }
    return exercise;
  }
}
