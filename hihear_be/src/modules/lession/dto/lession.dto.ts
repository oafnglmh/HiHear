import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsEnum, IsString } from 'class-validator';
import { Lession } from '../domain/lession.domain';
import type { Uuid } from 'src/common/types';
import { timeStamp } from 'console';
import { LessonCategory } from 'src/utils/lesson-category.enum';
import { MediaDto } from 'src/modules/media/dto/media.dto';
import { ExerciseDto } from 'src/modules/exercise/dto/exercise.dto';

export class LessionDto {
  @ApiProperty()
  id: Uuid;

  @ApiProperty()
  @IsString()
  title: string;

  @ApiPropertyOptional()
  description: string | null;

  @ApiPropertyOptional()
  @IsEnum(LessonCategory)
  category: LessonCategory;

  @ApiPropertyOptional()
  level: string | null;

  @ApiPropertyOptional()
  durationSeconds: number | null;

  @ApiPropertyOptional()
  xpReward: number | null;

  @ApiPropertyOptional({ type: () => Lession, isArray: true })
  prerequisiteLesson: Lession | null;

  @ApiPropertyOptional({ type: () => MediaDto, isArray: true })
  media: MediaDto[];

  @ApiPropertyOptional({ type: () => ExerciseDto, isArray: true })
  exercises: ExerciseDto[];

  @ApiProperty({ type: timeStamp })
  createdAt: Date;

  @ApiProperty({ type: timeStamp })
  updatedAt: Date;

  static fromDomain(lession: Lession): LessionDto {
    return {
      id: lession.id,
      title: lession.title,
      category: lession.category,
      level: lession.level,
      description: lession.description,
      durationSeconds: lession.durationSeconds,
      prerequisiteLesson: lession.prerequisiteLesson,
      media: MediaDto.fromDomains(lession.media),
      exercises: ExerciseDto.fromDomains(lession.exercise),
      xpReward: lession.xpReward,
      createdAt: lession.createdAt,
      updatedAt: lession.updatedAt,
    };
  }

  static fromDomains(lessions: Lession[]): LessionDto[] {
    return lessions.map((lession) => this.fromDomain(lession));
  }
}
