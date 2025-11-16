import { ApiProperty } from '@nestjs/swagger';
import {
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
} from 'class-validator';
import type { Uuid } from 'src/common/types';
import { LessonUpdate } from '../domain/lesson-update.domain';

export class LessonUpdateDto {
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
  category?: string;

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

  static toLessonUpdate(lessonUpdateDto: LessonUpdateDto): LessonUpdate {
    return {
      title: lessonUpdateDto.title,
      description: lessonUpdateDto.description,
      category: lessonUpdateDto.category,
      level: lessonUpdateDto.level,
      durationSeconds: lessonUpdateDto.durationSeconds ?? 0,
      prerequisiteLesson: lessonUpdateDto.prerequisiteLesson,
      xpReward: lessonUpdateDto.xpReward ?? 0,
    };
  }
}
