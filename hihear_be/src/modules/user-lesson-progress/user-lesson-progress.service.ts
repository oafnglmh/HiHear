import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { UserLessonProgressEntity } from './entities/user-lesson-progress.entity';
import { CreateProgressDto } from './dto/create-progress.dto';

@Injectable()
export class UserLessonProgressService {
  constructor(
    @InjectRepository(UserLessonProgressEntity)
    private readonly progressRepo: Repository<UserLessonProgressEntity>,
  ) {}

  async addProgress(dto: CreateProgressDto) {
    const { user_id, lesson_id, completed } = dto;

    let progress = await this.progressRepo.findOne({
      where: { user_id, lesson_id },
    });

    if (!progress) {
      progress = this.progressRepo.create({
        user_id,
        lesson_id,
        completed,
        completed_at: completed ? new Date() : null,
      });
    } else {
      if( completed === undefined ) {
        return progress;
      }
      progress.completed = completed;
      progress.completed_at = completed ? new Date() : null;
    }

    return this.progressRepo.save(progress);
  }

  async getAllProgress(user_id: string) {
    return this.progressRepo.find({
      where: { user_id },
    });
  }
}
