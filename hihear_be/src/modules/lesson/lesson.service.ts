import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { LessonEntity } from './entities/lesson.entity';
import { UserEntity } from '../users/entities/user.entity';
import { Lesson } from './domain/lesson.domain';
import { LessonCreate } from './domain/lesson-create.domain';
import { Uuid } from 'src/common/types';
import { LessonUpdate } from './domain/lesson-update.domain';
import { MediaService } from '../media/media.service';
import { ExerciseService } from '../exercises/exercises.service';
import { DataSource } from 'typeorm';
import { LessonVideoService } from '../lesson-video/lesson-video.service';
import { LessonVideoEntity } from '../lesson-video/entities/lesson-video.entity';
import { LessonCategory } from 'src/utils/enums/lesson-category.enum';

@Injectable()
export class LessonService {
  constructor(
    @InjectRepository(LessonEntity)
    private readonly lessonRepository: Repository<LessonEntity>,

    private readonly mediaService: MediaService,

    private readonly exerciseService: ExerciseService,
    private readonly dataSource: DataSource,
    private readonly lessonVideoService: LessonVideoService,
  ) {}

  private readonly lessonRelations = [
    'media',
    'prerequisiteLesson',
    'exercises',
    'lessonVideo',
  ];

  async create(
    currentUser: UserEntity,
    lessonCreate: LessonCreate,
  ): Promise<Lesson> {
    const queryRunner = this.dataSource.createQueryRunner();

    await queryRunner.connect();
    await queryRunner.startTransaction();

    try {
      await this.verifyLessonNotExisting(lessonCreate.title);

      const prerequisiteLesson = lessonCreate.prerequisiteLesson
        ? await this.findPrerequisiteLesson(lessonCreate.prerequisiteLesson)
        : null;
      const lessonEntity = queryRunner.manager.create(LessonEntity, {
        ...lessonCreate,
        prerequisiteLesson,
        user: currentUser,
      } as Partial<LessonEntity>);

      if (lessonCreate.mediaId) {
        await this.mediaService.assignMediaToLesson(
          lessonCreate.mediaId,
          lessonEntity,
        );
      }
      if (lessonCreate.exercises?.length) {
        await this.exerciseService.createExerciseToLesson(
          queryRunner,
          lessonEntity,
          lessonCreate.exercises,
        );
      }

      if (lessonCreate.videoData) {
        const video = queryRunner.manager.create(
          LessonVideoEntity,
          lessonCreate.videoData,
        );

        lessonEntity.lessonVideo = video;
      }
      await queryRunner.manager.save(lessonEntity);

      await queryRunner.commitTransaction();

      const lesson = await this.getLessonOrThrow(lessonEntity.id);
      return Lesson.fromEntity(lesson);
    } catch (error) {
      await queryRunner.rollbackTransaction();
      throw error;
    } finally {
      await queryRunner.release();
    }
  }

  async update(
    currentUser: UserEntity,
    id: Uuid,
    lessonUpdate: LessonUpdate,
  ): Promise<Lesson> {
    await this.getLessonOrThrow(id);

    const prerequisiteLesson = lessonUpdate.prerequisiteLesson
      ? await this.findPrerequisiteLesson(lessonUpdate.prerequisiteLesson)
      : null;

    return Lesson.fromEntity(
      await this.lessonRepository.save({
        id,
        ...lessonUpdate,
        prerequisiteLesson,
        user: currentUser,
      } as Partial<LessonEntity>),
    );
  }

  async findAll(): Promise<Lesson[]> {
    const lessons = await this.lessonRepository.find({
      relations: this.lessonRelations,
    });

    return Lesson.fromEntities(lessons);
  }

  async findById(id: Uuid): Promise<Lesson> {
    const lessonEntity = await this.getLessonOrThrow(id);

    return Lesson.fromEntity(lessonEntity);
  }

  async remove(id: Uuid): Promise<void> {
    const lessonEntity = await this.getLessonOrThrow(id);

    await this.lessonRepository.remove(lessonEntity);
  }

  private async getLessonOrThrow(id: Uuid): Promise<LessonEntity> {
    const lessonEntity = await this.lessonRepository.findOne({
      where: { id },
      relations: this.lessonRelations,
    });

    if (!lessonEntity) {
      throw new NotFoundException(`Lession with id ${id} not found`);
    }

    return lessonEntity;
  }

  private async verifyLessonNotExisting(title: string): Promise<void> {
    const existingLesson = await this.lessonRepository.findOneBy({
      title: title,
    });

    if (existingLesson) {
      throw new ForbiddenException('A lesson for this title already exists');
    }
  }

  private async findPrerequisiteLesson(
    prerequisiteLessonId: Uuid,
  ): Promise<LessonEntity | null> {
    const lesson = await this.lessonRepository.findOne({
      where: { id: prerequisiteLessonId },
    });

    if (!lesson) {
      throw new NotFoundException(
        `Prerequisite lesson with ID ${prerequisiteLessonId} not found`,
      );
    }

    return lesson;
  }
  async findByCategory(category: LessonCategory): Promise<Lesson[]> {
    const lessons = await this.lessonRepository.find({
      where: { category },
      relations: this.lessonRelations,
    });

    return Lesson.fromEntities(lessons);
  }
}
