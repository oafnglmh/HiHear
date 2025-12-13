import {
  IsArray,
  IsNumber,
  IsString,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { LessonVideoTranscriptionDto } from './lesson-video-transcription.dto';

export class LessonVideoCreateDto {
  @IsString()
  fileName: string;

  @IsString()
  fileSize: string;

  @IsString()
  videoUrl: string;

  @IsString()
  cloudinaryId: string;

  @IsNumber()
  duration: number;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => LessonVideoTranscriptionDto)
  transcriptions: LessonVideoTranscriptionDto[];
}
