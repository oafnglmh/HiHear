import { ApiProperty } from '@nestjs/swagger';
import {
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
} from 'class-validator';
import { LessonCreate } from '../domain/lesson-create.domain';
import type { Uuid } from 'src/common/types';

export class LessonCreateDto {
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

  @ApiProperty({ description: 'ID của media đã upload', required: false })
  @IsOptional()
  @IsUUID()
  readonly mediaId?: Uuid;

  static toLessonCreate(lessonCreateDto: LessonCreateDto): LessonCreate {
    return {
      title: lessonCreateDto.title,
      description: lessonCreateDto.description ?? null,
      category: lessonCreateDto.category,
      level: lessonCreateDto.level,
      durationSeconds: lessonCreateDto.durationSeconds ?? 0,
      prerequisiteLesson: lessonCreateDto.prerequisiteLesson ?? null,
      xpReward: lessonCreateDto.xpReward ?? 0,
      mediaId: lessonCreateDto.mediaId,
    };
  }
}
