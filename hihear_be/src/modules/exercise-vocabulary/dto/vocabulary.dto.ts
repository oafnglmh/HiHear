import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsArray, ArrayNotEmpty } from 'class-validator';
import { Vocabulary } from '../domain/vocabulary.domain';
import { timeStamp } from 'console';
import type { Uuid } from 'src/common/types';

export class VocabularyDto {
  @ApiProperty()
  readonly id: Uuid;

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

  @ApiProperty({ type: timeStamp })
  readonly createdAt: Date;

  @ApiProperty({ type: timeStamp })
  readonly updatedAt: Date;

  static fromDomain(domain: Vocabulary): VocabularyDto {
    return {
      id: domain.id,
      question: domain.question,
      choices: domain.choices,
      correctAnswer: domain.correctAnswer,
      createdAt: domain.createdAt,
      updatedAt: domain.updatedAt,
    };
  }

  static fromDomains(domains: Vocabulary[]): VocabularyDto[] {
    return domains.map((d) => this.fromDomain(d));
  }
}
