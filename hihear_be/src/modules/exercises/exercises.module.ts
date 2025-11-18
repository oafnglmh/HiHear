import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ExercisesEntity } from './entities/exercises.entity';
import { ExerciseService } from './exercises.service';
import { ExerciseController } from './exercises.controller';
import { ExerciseVocabularyModule } from '../exercise-vocabulary/exercise-vocabulary.module';
import { ExerciseGrammaModule } from '../exercise-gramma/exercise-gramma.module';
import { ExerciseListeningModule } from '../exercise-listening/exercise-listening.module';
import { MediaModule } from '../media/media.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([ExercisesEntity]),
    ExerciseVocabularyModule,
    ExerciseGrammaModule,
    ExerciseListeningModule,
    MediaModule,
  ],
  controllers: [ExerciseController],
  providers: [ExerciseService],
  exports: [ExerciseService],
})
export class ExercisesModule {}
