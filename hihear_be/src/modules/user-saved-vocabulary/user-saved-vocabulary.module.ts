import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserSavedVocabulary } from './entities/user-saved-vocabulary.entity';
import { UserSavedVocabularyService } from './user-saved-vocabulary.service';
import { UserSavedVocabularyController } from './user-saved-vocabulary.controller';

@Module({
  imports: [TypeOrmModule.forFeature([UserSavedVocabulary])],
  providers: [UserSavedVocabularyService],
  controllers: [UserSavedVocabularyController],
  exports: [UserSavedVocabularyService],
})
export class UserSavedVocabularyModule {}
