import { Module } from '@nestjs/common';
import { LessonEntity } from '../lesson/entities/lesson.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LessonVideoEntity } from './entities/lesson-video.entity';
import { LessonVideoService } from './lesson-video.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      LessonVideoEntity,
      LessonEntity,
    ]),
  ],
  providers: [LessonVideoService],
  exports: [LessonVideoService],
})
export class LessonVideoModule {}
