import { ApiProperty } from '@nestjs/swagger';
import {
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
} from 'class-validator';
import { LessionCreate } from '../domain/lession-create.domain';
import { Uuid } from 'src/common/types';

export class LessionCreateDto {
  @ApiProperty()
  @IsString()
  title: string;

  @ApiProperty()
  @IsOptional()
  @IsString()
  description?: string | null;

  @ApiProperty()
  @IsString()
  @MaxLength(100)
  category: string | null;

  @ApiProperty()
  @IsString()
  @MaxLength(10)
  level: string | null;

  @ApiProperty({ default: 0 })
  @IsOptional()
  @IsInt()
  durationSeconds?: number | null;

  @ApiProperty({ default: 0 })
  @IsOptional()
  @IsInt()
  xpReward?: number | null;

  @ApiProperty()
  @IsOptional()
  @IsUUID()
  prerequisiteLesson?: Uuid | null;

  static toLessionCreate(lessionCreateDto: LessionCreateDto): LessionCreate {
    return {
      title: lessionCreateDto.title,
      description: lessionCreateDto.description ?? null,
      category: lessionCreateDto.category,
      level: lessionCreateDto.level,
      durationSeconds: lessionCreateDto.durationSeconds ?? 0,
      prerequisiteLesson: lessionCreateDto.prerequisiteLesson ?? null,
      xpReward: lessionCreateDto.xpReward ?? 0,
    };
  }
}
