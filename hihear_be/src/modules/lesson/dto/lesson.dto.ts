import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString } from 'class-validator';
import { Lesson } from '../domain/lesson.domain';
import type { Uuid } from 'src/common/types';
import { timeStamp } from 'console';
import { Media } from 'src/modules/media/domain/media';

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

  @ApiPropertyOptional({ type: () => Lesson, isArray: true })
  prerequisiteLesson: Lesson | null;

  @ApiPropertyOptional({ type: () => Media, isArray: true })
  media: Media[] | null;

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
      prerequisiteLesson: lesson.prerequisiteLesson,
      media: lesson.media,
      xpReward: lesson.xpReward,
      createdAt: lesson.createdAt,
      updatedAt: lesson.updatedAt,
    };
  }

  static fromDomains(lessons: Lesson[]): LessonDto[] {
    return lessons.map((lesson) => this.fromDomain(lesson));
  }
}
