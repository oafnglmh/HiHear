import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LessonEntity } from './entities/lesson.entity';
import { LessonController } from './lesson.controller';
import { LessonService } from './lesson.service';
import { MediaModule } from '../media/media.module';
import { ExercisesModule } from '../exercises/exercises.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([LessonEntity]),
    MediaModule,
    ExercisesModule,
  ],
  controllers: [LessonController],
  providers: [LessonService],
})
export class LessonModule {}
