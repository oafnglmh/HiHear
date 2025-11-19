import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString, IsOptional, IsArray, IsUUID } from 'class-validator';
import { ListeningCreate } from '../domain/listening-create.domain';
import type { Uuid } from 'src/common/types';

export class ListeningCreateDto {
  @ApiPropertyOptional({
    example: '1dfb3be1-5a60-44cd-a0cf-45c35d123abc',
    description: 'ID của media đã upload',
  })
  @IsUUID()
  readonly mediaId: Uuid;

  @ApiPropertyOptional({ description: 'Bản transcript của audio' })
  @IsOptional()
  @IsString()
  readonly transcript: string | null;

  @ApiProperty({
    description: 'Danh sách các lựa chọn đáp án',
    example: ['Hello', 'Goodbye', 'Thanks'],
  })
  @IsArray()
  @IsString({ each: true })
  readonly choices: string[];

  @ApiProperty({
    description: 'Đáp án đúng',
    example: 'Hello',
  })
  @IsString()
  readonly correctAnswer: string;

  static toListeningCreate(listening: ListeningCreateDto): ListeningCreate {
    return {
      mediaId: listening.mediaId,
      transcript: listening.transcript ?? null,
      choices: listening.choices,
      correctAnswer: listening.correctAnswer,
    };
  }
}
