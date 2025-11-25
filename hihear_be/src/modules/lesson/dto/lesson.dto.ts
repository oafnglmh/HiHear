import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString } from 'class-validator';
import { Lesson } from '../domain/lesson.domain';
import type { Uuid } from 'src/common/types';
import { timeStamp } from 'console';
import { Media } from 'src/modules/media/domain/media';
import { Exercises } from 'src/modules/exercises/domain/exercises.domain';

export class LessonDto {
  @ApiProperty()
  id: Uuid;

  @ApiProperty()
  @IsString()
  title: string;

  @ApiPropertyOptional()
  description: string | null;

  @ApiPropertyOptional()
  category: string | null;

  @ApiPropertyOptional()
  level: string | null;

  @ApiPropertyOptional()
  durationSeconds: number | null;

  @ApiPropertyOptional()
  xpReward: number | null;

  // @ApiPropertyOptional({ type: () => Lesson })
  // prerequisiteLesson: Lesson | null;

  @ApiPropertyOptional()
  prerequisiteLessonId: string | null;

  @ApiPropertyOptional({ type: () => Media, isArray: true })
  media: Media[] | null;

  @ApiPropertyOptional({ type: () => Exercises, isArray: true })
  exercises: Exercises[] | null;

  @ApiProperty({ type: timeStamp })
  createdAt: Date;

  @ApiProperty({ type: timeStamp })
  updatedAt: Date;

  static fromDomain(lesson: Lesson): LessonDto {
    return {
      id: lesson.id,
      title: lesson.title,
      category: lesson.category,
      level: lesson.level,
      description: lesson.description,
      durationSeconds: lesson.durationSeconds,
      prerequisiteLessonId: lesson.prerequisiteLessonId,
      media: lesson.media,
      exercises: lesson.exercises ?? [],
      xpReward: lesson.xpReward,
      createdAt: lesson.createdAt,
      updatedAt: lesson.updatedAt,
    };
  }

  static fromDomains(lessons: Lesson[]): LessonDto[] {
    return lessons.map((lesson) => this.fromDomain(lesson));
  }
}
