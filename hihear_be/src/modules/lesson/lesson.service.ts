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

@Injectable()
export class LessonService {
  constructor(
    @InjectRepository(LessonEntity)
    private readonly lessonRepository: Repository<LessonEntity>,

    private readonly mediaService: MediaService,
  ) {}

  async create(
    currentUser: UserEntity,
    lessonCreate: LessonCreate,
  ): Promise<Lesson> {
    await this.verifyLessonNotExisting(lessonCreate.title);

    let prerequisiteLesson: LessonEntity | null = null;
    if (lessonCreate.prerequisiteLesson) {
      prerequisiteLesson = await this.findPrerequisiteLesson(
        lessonCreate.prerequisiteLesson,
      );
    }

    const lesson = await this.lessonRepository.save(
      this.lessonRepository.create({
        ...lessonCreate,
        prerequisiteLesson,
        user: currentUser,
      } as Partial<LessonEntity>),
    );

    if (lessonCreate.mediaId) {
      await this.mediaService.assignMediaToLesson(lessonCreate.mediaId, lesson);
    }

    return Lesson.fromEntity(lesson);
  }

  async update(
    currentUser: UserEntity,
    id: Uuid,
    lessonUpdate: LessonUpdate,
  ): Promise<Lesson> {
    const lessonEntity = await this.findLessonById(id);

    if (!lessonEntity) {
      throw new NotFoundException(`Lesson with id ${id} not found`);
    }

    let prerequisiteLesson: LessonEntity | null = null;
    if (lessonUpdate.prerequisiteLesson) {
      prerequisiteLesson = await this.findPrerequisiteLesson(
        lessonUpdate.prerequisiteLesson,
      );
    }

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
    const lessons = await this.lessonRepository.find();

    return Lesson.fromEntities(lessons);
  }

  async findById(id: Uuid): Promise<Lesson> {
    const lessonEntity = await this.findLessonById(id);

    if (!lessonEntity) {
      throw new NotFoundException(`Lesson with id ${id} not found`);
    }

    return Lesson.fromEntity(lessonEntity);
  }

  async remove(id: Uuid): Promise<void> {
    const lessonEntity = await this.findLessonById(id);

    if (!lessonEntity) {
      throw new NotFoundException(`Lesson with id ${id} not found`);
    }

    await this.lessonRepository.remove(lessonEntity);
  }

  private async findLessonById(id: Uuid): Promise<LessonEntity | null> {
    const lessonEntity = await this.lessonRepository.findOneBy({ id });

    if (!lessonEntity) {
      return null;
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
}
