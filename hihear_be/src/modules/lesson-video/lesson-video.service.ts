import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { LessonVideoEntity } from './entities/lesson-video.entity';
import { LessonVideoCreateDto } from './dto/lesson-video-create.dto';
import { Uuid } from 'src/common/types';
import { LessonEntity } from '../lesson/entities/lesson.entity';

@Injectable()
export class LessonVideoService {
  constructor(
    @InjectRepository(LessonVideoEntity)
    private readonly repo: Repository<LessonVideoEntity>,
  ) {}

  async create(dto: LessonVideoCreateDto): Promise<LessonVideoEntity> {
    const entity = this.repo.create(dto);
    return this.repo.save(entity);
  }

  async findByLessonId(lessonId: Uuid) {
    return this.repo
      .createQueryBuilder('video')
      .leftJoin('video.lesson', 'lesson')
      .where('lesson.id = :lessonId', { lessonId })
      .getOne();
  }
}
