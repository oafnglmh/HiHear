import { ApiProperty } from '@nestjs/swagger';
import {
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
} from 'class-validator';
import { LessionCreate } from '../domain/lession-create.domain';
import { Uuid } from 'src/common/types';
import { LessonCategory } from 'src/utils/lesson-category.enum';
import { MediaCreateDto } from 'src/modules/media/dto/media-create.dto';
import { ExerciseCreateDto } from 'src/modules/exercise/dto/exercise-create.dto';

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
  @IsEnum(LessonCategory)
  category: LessonCategory;

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

  @ApiProperty()
  @IsOptional()
  media?: MediaCreateDto[];

  @ApiProperty()
  @IsOptional()
  exercises?: ExerciseCreateDto[];

  static toLessionCreate(lessionCreateDto: LessionCreateDto): LessionCreate {
    return {
      title: lessionCreateDto.title,
      description: lessionCreateDto.description ?? null,
      category: lessionCreateDto.category,
      level: lessionCreateDto.level,
      durationSeconds: lessionCreateDto.durationSeconds ?? 0,
      prerequisiteLesson: lessionCreateDto.prerequisiteLesson ?? null,
      xpReward: lessionCreateDto.xpReward ?? 0,
      media: lessionCreateDto.media
        ? lessionCreateDto.media.map((m) => MediaCreateDto.toMediaCreate(m))
        : [],
      exercises: lessionCreateDto.exercises
        ? lessionCreateDto.exercises.map((m) =>
            ExerciseCreateDto.toExerciseCreate(m),
          )
        : [],
    };
  }
}
