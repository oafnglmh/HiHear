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

@Injectable()
export class LessionService {
  constructor(
    @InjectRepository(LessionEntity)
    private readonly lessionRepository: Repository<LessionEntity>,
  ) {}

  async create(
    currentUser: UserEntity,
    lessionCreate: LessionCreate,
  ): Promise<Lession> {
    await this.verifyLessionNotExisting(lessionCreate.title);

    let prerequisiteLesson: LessionEntity | null = null;
    if (lessionCreate.prerequisiteLesson) {
      prerequisiteLesson = await this.findPrerequisiteLesson(
        lessionCreate.prerequisiteLesson,
      );
    }

    return Lession.fromEntity(
      await this.lessionRepository.save(
        this.lessionRepository.create({
          ...lessionCreate,
          prerequisiteLesson,
          user: currentUser,
        } as Partial<LessionEntity>),
      ),
    );
  }

  async update(
    currentUser: UserEntity,
    id: Uuid,
    lessionUpdate: LessionUpdate,
  ): Promise<Lession> {
    const lessionEntity = await this.findLessionById(id);

    if (!lessionEntity) {
      throw new NotFoundException(`Lession with id ${id} not found`);
    }

    let prerequisiteLesson: LessionEntity | null = null;
    if (lessionUpdate.prerequisiteLesson) {
      prerequisiteLesson = await this.findPrerequisiteLesson(
        lessionUpdate.prerequisiteLesson,
      );
    }

    return Lession.fromEntity(
      await this.lessionRepository.save({
        id,
        ...lessionUpdate,
        prerequisiteLesson,
        user: currentUser,
      } as Partial<LessionEntity>),
    );
  }

  async findAll(): Promise<Lession[]> {
    const lessions = await this.lessionRepository.find();

    return Lession.fromEntities(lessions);
  }

  async findById(id: Uuid): Promise<Lession> {
    const lessionEntity = await this.findLessionById(id);

    if (!lessionEntity) {
      throw new NotFoundException(`Lession with id ${id} not found`);
    }

    return Lession.fromEntity(lessionEntity);
  }

  async remove(id: Uuid): Promise<void> {
    const lessionEntity = await this.findLessionById(id);

    if (!lessionEntity) {
      throw new NotFoundException(`Lession with id ${id} not found`);
    }

    await this.lessionRepository.remove(lessionEntity);
  }

  private async findLessionById(id: Uuid): Promise<LessionEntity | null> {
    const lessionEntity = await this.lessionRepository.findOneBy({ id });

    if (!lessionEntity) {
      return null;
    }

    return lessionEntity;
  }

  private async verifyLessionNotExisting(title: string): Promise<void> {
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
