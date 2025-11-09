import { ApiProperty } from '@nestjs/swagger';
import {
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
} from 'class-validator';
import type { Uuid } from 'src/common/types';
import { LessionUpdate } from '../domain/lession-update.domain';
import { LessonCategory } from 'src/utils/lesson-category.enum';
import { MediaCreate } from 'src/modules/media/domain/media-create.domain';

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
  @IsEnum(LessonCategory)
  category?: LessonCategory;

  @ApiProperty()
  @IsOptional()
  @IsString()
  @MaxLength(10)
  level?: string;

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

  @ApiProperty()
  @IsOptional()
  media?: MediaCreate[];

  static toLessionUpdate(lessionUpdateDto: LessionUpdateDto): LessionUpdate {
    return {
      title: lessionUpdateDto.title,
      description: lessionUpdateDto.description,
      category: lessionUpdateDto.category,
      level: lessionUpdateDto.level,
      durationSeconds: lessionUpdateDto.durationSeconds ?? 0,
      prerequisiteLesson: lessionUpdateDto.prerequisiteLesson,
      xpReward: lessionUpdateDto.xpReward ?? 0,
      media: lessionUpdateDto.media ?? [],
    };
  }
}
