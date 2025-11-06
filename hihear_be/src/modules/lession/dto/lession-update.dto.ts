import { ApiProperty } from '@nestjs/swagger';
import {
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
} from 'class-validator';
import type { Uuid } from 'src/common/types';
import { LessionUpdate } from '../domain/lession-update.domain';

export class LessionUpdateDto {
  @ApiProperty()
  @IsOptional()
  @IsString()
  title?: string;

  @ApiProperty()
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty()
  @IsOptional()
  @IsString()
  @MaxLength(100)
  category: string;

  @ApiProperty()
  @IsOptional()
  @IsString()
  @MaxLength(10)
  level: string;

  @ApiProperty({ default: 0 })
  @IsOptional()
  @IsInt()
  durationSeconds?: number;

  @ApiProperty({ default: 0 })
  @IsOptional()
  @IsInt()
  xpReward?: number;

  @ApiProperty()
  @IsOptional()
  @IsUUID()
  prerequisiteLesson?: Uuid;

  static toLessionUpdate(lessionUpdateDto: LessionUpdateDto): LessionUpdate {
    return {
      title: lessionUpdateDto.title,
      description: lessionUpdateDto.description,
      category: lessionUpdateDto.category,
      level: lessionUpdateDto.level,
      durationSeconds: lessionUpdateDto.durationSeconds ?? 0,
      prerequisiteLesson: lessionUpdateDto.prerequisiteLesson,
      xpReward: lessionUpdateDto.xpReward ?? 0,
    };
  }
}
