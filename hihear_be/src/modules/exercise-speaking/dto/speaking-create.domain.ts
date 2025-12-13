import { ApiProperty } from '@nestjs/swagger';
import { ArrayNotEmpty, IsArray, IsString } from 'class-validator';
import { SpeakingCreate } from '../domain/speaking-create.domain';

export class SpeakingCreateDto {
  @IsString()
  readonly number: string;

  @IsArray()
  @ArrayNotEmpty()
  @IsString({ each: true })
  readonly read: string[];

  static toSpeakingCreate(speakingDto: SpeakingCreateDto): SpeakingCreate {
    return {
      number: speakingDto.number,
      read: speakingDto.read,
    };
  }
}
