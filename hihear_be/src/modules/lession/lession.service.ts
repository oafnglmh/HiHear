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
          createdBy: currentUser,
        } as Partial<LessionEntity>),
      ),
    );
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
