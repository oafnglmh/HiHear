import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { LessionEntity } from './entities/lession.entity';
import { UserEntity } from '../users/entities/user.entity';
import { Lession } from './domain/lession.domain';
import { LessionCreate } from './domain/lession-create.domain';
import { Uuid } from 'src/common/types';
import { LessionUpdate } from './domain/lession-update.domain';
import { MediaEntity } from '../media/entities/media.entity';
import { ExerciseEntity } from '../exercise/entities/exercise.entity';

@Injectable()
export class LessionService {
  constructor(
    @InjectRepository(LessionEntity)
    private readonly lessionRepository: Repository<LessionEntity>,

    @InjectRepository(MediaEntity)
    private readonly mediaRepository: Repository<MediaEntity>,

    @InjectRepository(ExerciseEntity)
    private readonly exerciseRepository: Repository<ExerciseEntity>,
  ) {}

  async create(
    currentUser: UserEntity,
    lessionCreate: LessionCreate,
  ): Promise<Lession> {
    await this.verifyTitleLessionNotExisting(lessionCreate.title);

    const prerequisiteLesson = lessionCreate.prerequisiteLesson
      ? await this.findPrerequisiteLesson(lessionCreate.prerequisiteLesson)
      : null;

    return Lession.fromEntity(
      await this.lessionRepository.save(
        this.lessionRepository.create({
          ...lessionCreate,
          prerequisiteLesson,
          user: currentUser,
          media: lessionCreate.media?.map((m) =>
            this.mediaRepository.create({ ...m }),
          ),
          exercises: lessionCreate.exercises?.map((e) =>
             this.exerciseRepository.create({ ...e }),
          ),
        } as Partial<LessionEntity>),
      ),
    );
  }

  async update(
    currentUser: UserEntity,
    id: Uuid,
    lessionUpdate: LessionUpdate,
  ): Promise<Lession> {
    await this.getLessionOrThrow(id);

    const prerequisiteLesson = lessionUpdate.prerequisiteLesson
      ? await this.findPrerequisiteLesson(lessionUpdate.prerequisiteLesson)
      : null;

    return Lession.fromEntity(
      await this.lessionRepository.save({
        id,
        ...lessionUpdate,
        prerequisiteLesson,
        user: currentUser,
        media: lessionUpdate.media?.map((m) =>
          this.mediaRepository.create({ ...m }),
        ),
      } as Partial<LessionEntity>),
    );
  }

  async findAll(): Promise<Lession[]> {
    const lessions = await this.lessionRepository.find({
      relations: ['prerequisiteLesson'],
    });

    return Lession.fromEntities(lessions);
  }

  async findById(id: Uuid): Promise<Lession> {
    const lessionEntity = await this.getLessionOrThrow(id);

    return Lession.fromEntity(lessionEntity);
  }

  async remove(id: Uuid): Promise<void> {
    const lessionEntity = await this.getLessionOrThrow(id);

    await this.lessionRepository.remove(lessionEntity);
  }

  private async getLessionOrThrow(id: Uuid): Promise<LessionEntity> {
    const lessionEntity = await this.lessionRepository.findOne({
      where: { id },
      relations: ['prerequisiteLesson'],
    });

    if (!lessionEntity) {
      throw new NotFoundException(`Lession with id ${id} not found`);
    }

    return lessionEntity;
  }

  private async verifyTitleLessionNotExisting(title: string): Promise<void> {
    const existingLession = await this.lessionRepository.findOneBy({
      title: title,
    });

    if (existingLession) {
      throw new ForbiddenException('A lession for this title already exists');
    }
  }

  private async findPrerequisiteLesson(
    prerequisiteLessonId: Uuid,
  ): Promise<LessionEntity | null> {
    const lesson = await this.lessionRepository.findOne({
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
