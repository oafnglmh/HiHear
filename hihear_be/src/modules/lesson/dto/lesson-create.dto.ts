import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
  ValidateNested,
} from 'class-validator';
import { LessonCreate } from '../domain/lesson-create.domain';
import type { Uuid } from 'src/common/types';
import { ExercisesCreateDto } from 'src/modules/exercises/dto/exercises-create.dto';
import { Type } from 'class-transformer';
import { LessonCategory } from 'src/utils/enums/lesson-category.enum';

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
  category: LessonCategory | null;

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
  readonly mediaId?: Uuid | null;

  @ApiPropertyOptional({ type: () => [ExercisesCreateDto], isArray: true })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ExercisesCreateDto)
  @IsOptional()
  exercises?: ExercisesCreateDto[];

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
      exercises: lessonCreateDto.exercises ?? [],
    };
  }
}
