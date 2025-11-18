import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString, IsOptional, IsArray } from 'class-validator';
import { timeStamp } from 'console';
import type { Uuid } from 'src/common/types';
import { Listening } from '../domain/listening.domain';
import { Media } from 'src/modules/media/domain/media';

export class ListeningDto {
  @ApiProperty()
  readonly id: Uuid;

  @ApiPropertyOptional({ type: () => Media, isArray: true })
  media: Media | null;

  @ApiPropertyOptional({})
  @IsOptional()
  @IsString()
  readonly transcript: string | null;

  @ApiProperty({})
  @IsArray()
  @IsString({ each: true })
  readonly choices: string[];

  @ApiProperty({})
  @IsString()
  readonly correctAnswer: string;

  @ApiProperty({ type: timeStamp })
  readonly createdAt: Date;

  @ApiProperty({ type: timeStamp })
  readonly updatedAt: Date;

  static fromDomain(listening: Listening): ListeningDto {
    return {
      id: listening.id,
      media: listening.media,
      transcript: listening.transcript ?? null,
      choices: listening.choices,
      correctAnswer: listening.correctAnswer,
      createdAt: listening.createdAt,
      updatedAt: listening.updatedAt,
    };
  }

  static fromDomains(domains: ListeningDto[]): ListeningDto[] {
    return domains.map((d) => ListeningDto.fromDomain(d));
  }
}
