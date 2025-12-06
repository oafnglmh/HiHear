import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserLessonProgressEntity } from './entities/user-lesson-progress.entity';
import { UserLessonProgressService } from './user-lesson-progress.service';
import { UserLessonProgressController } from './user-lesson-progress.controller';

@Module({
  imports: [TypeOrmModule.forFeature([UserLessonProgressEntity])],
  controllers: [UserLessonProgressController],
  providers: [UserLessonProgressService],
  exports: [UserLessonProgressService],
})
export class UserLessonProgressModule {}
