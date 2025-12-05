import { Controller, Post, Body, ValidationPipe } from '@nestjs/common';
import { UserSavedVocabularyService } from './user-saved-vocabulary.service';
import { CreateUserSavedVocabularyDto } from './dto/create-user-saved-vocabulary.dto';
import { UserSavedVocabulary } from './entities/user-saved-vocabulary.entity';

@Controller('user-saved-vocabularies')
export class UserSavedVocabularyController {
  constructor(private readonly vocabService: UserSavedVocabularyService) {}

  @Post()
  async create(
    @Body(new ValidationPipe({ whitelist: true, forbidNonWhitelisted: true }))
    dto: CreateUserSavedVocabularyDto,
  ): Promise<UserSavedVocabulary> {
    return this.vocabService.addVocabulary(dto);
  }
}
