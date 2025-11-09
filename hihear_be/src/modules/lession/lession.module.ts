import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LessionEntity } from './entities/lession.entity';
import { LessionController } from './lession.controller';
import { LessionService } from './lession.service';
import { MediaModule } from '../media/media.module';
import { ExerciseModule } from '../exercise/exercise.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([LessionEntity]),
    MediaModule,
    ExerciseModule,
  ],
  controllers: [LessionController],
  providers: [LessionService],
})
export class LessionModule {}
