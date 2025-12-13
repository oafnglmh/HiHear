import { IsNumber, IsString } from 'class-validator';

export class LessonVideoTranscriptionDto {
  @IsString()
  vi: string;

  @IsString()
  en: string;

  @IsString()
  ko: string;

  @IsNumber()
  start: number;

  @IsNumber()
  end: number;
}