import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ExerciseEntity } from './entities/exercise.entity';

@Module({
  imports: [TypeOrmModule.forFeature([ExerciseEntity])],
  controllers: [],
  providers: [],
})
export class ExerciseModule {}
