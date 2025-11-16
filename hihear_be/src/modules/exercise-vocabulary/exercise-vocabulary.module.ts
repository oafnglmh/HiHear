import { Module } from '@nestjs/common';
import { VocabularyEntity } from './entities/vocabulary.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VocabularyService } from './exercise-vocabulary.service';

@Module({
  imports: [TypeOrmModule.forFeature([VocabularyEntity])],
  controllers: [],
  providers: [VocabularyService],
  exports: [VocabularyService],
})
export class ExerciseVocabularyModule {}
