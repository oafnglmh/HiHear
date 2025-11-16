import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsArray, ArrayNotEmpty } from 'class-validator';
import { VocabularyCreate } from '../domain/vocabulary-create.domain';

export class VocabularyCreateDto {
  @ApiProperty({ description: 'Câu hỏi từ vựng' })
  @IsString()
  question: string;

  @ApiProperty({ description: 'Các lựa chọn trả lời', type: [String] })
  @IsArray()
  @ArrayNotEmpty()
  @IsString({ each: true })
  choices: string[];

  @ApiProperty({ description: 'Đáp án đúng' })
  @IsString()
  correctAnswer: string;

  static toVocabularyCreate(
    vocabularyCreateDto: VocabularyCreateDto,
  ): VocabularyCreate {
    return {
      question: vocabularyCreateDto.question,
      choices: vocabularyCreateDto.choices,
      correctAnswer: vocabularyCreateDto.correctAnswer,
    };
  }
}
