import { Injectable, BadRequestException, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { UserSavedVocabulary } from './entities/user-saved-vocabulary.entity';
import { CreateUserSavedVocabularyDto } from './dto/create-user-saved-vocabulary.dto';

@Injectable()
export class UserSavedVocabularyService {
  private readonly logger = new Logger(UserSavedVocabularyService.name);

  constructor(
    @InjectRepository(UserSavedVocabulary)
    private readonly vocabRepo: Repository<UserSavedVocabulary>,
  ) {}

  async addVocabulary(dto: CreateUserSavedVocabularyDto): Promise<UserSavedVocabulary> {
    const word = dto.word.trim();
    const meaning = dto.meaning.trim();
    const category = dto.category.trim();

    const existing = await this.vocabRepo.findOne({
      where: { userId: dto.userId, word },
    });

    if (existing) {
      throw new BadRequestException(`Từ "${word}" đã tồn tại trong danh sách.`);
    }

    const vocab = this.vocabRepo.create({ ...dto, word, meaning, category });

    try {
      return await this.vocabRepo.save(vocab);
    } catch (error) {
      this.logger.error('Thêm từ vựng thất bại', error.stack);
      throw new BadRequestException('Có lỗi xảy ra khi thêm từ vựng.');
    }
  }
}
