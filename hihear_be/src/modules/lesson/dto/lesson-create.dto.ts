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
import { LessonVideoCreateDto } from 'src/modules/lesson-video/dto/lesson-video-create.dto';

export class LessonCreateDto {
  @ApiProperty({
    example: 'Ngữ pháp cơ bản: Câu đơn – câu ghép',
    description: 'Tiêu đề của bài học',
  })
  @IsString()
  title: string;

  @ApiPropertyOptional({
    example: 'Bài học giới thiệu các loại câu trong ngữ pháp tiếng Việt.',
    description: 'Mô tả bài học',
  })
  @IsOptional()
  @IsString()
  description?: string | null;

  @ApiProperty({
    example: LessonCategory.GRAMMAR,
    description: 'Danh mục bài học',
  })
  @IsString()
  @MaxLength(100)
  category: LessonCategory | null;

  @ApiProperty({
    example: 'BEGINNER',
    description: 'Trình độ bài học',
  })
  @IsString()
  @MaxLength(10)
  level: string | null;

  @ApiPropertyOptional({
    example: 900,
    description: 'Thời gian học (tính bằng giây)',
    default: 0,
  })
  @IsOptional()
  @IsInt()
  durationSeconds?: number | null;

  @ApiPropertyOptional({
    example: 30,
    description: 'Điểm kinh nghiệm (XP) thưởng khi hoàn thành bài học',
    default: 0,
  })
  @IsOptional()
  @IsInt()
  xpReward?: number | null;

  @ApiPropertyOptional({
    example: '550e8400-e29b-41d4-a716-446655440000',
    description: 'ID bài học tiên quyết (nếu có)',
  })
  @IsOptional()
  @IsUUID()
  prerequisiteLesson?: Uuid | null;

  @ApiPropertyOptional({
    example: '1dfb3be1-5a60-44cd-a0cf-45c35d123abc',
    description: 'ID của media đã upload',
    required: false,
  })
  @IsOptional()
  @IsUUID()
  readonly mediaId?: Uuid | null;

  @ApiPropertyOptional({ type: () => [ExercisesCreateDto], isArray: true })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ExercisesCreateDto)
  @IsOptional()
  exercises?: ExercisesCreateDto[];

  @ApiPropertyOptional({ type: () => LessonVideoCreateDto })
  @IsOptional()
  @ValidateNested()
  @Type(() => LessonVideoCreateDto)
  videoData?: LessonVideoCreateDto;

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
      videoData: lessonCreateDto.videoData,
    };
  }
}
