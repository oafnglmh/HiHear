import { ApiProperty } from '@nestjs/swagger';
import { ArrayNotEmpty, IsArray, IsString } from 'class-validator';
import { timeStamp } from 'console';
import type { Uuid } from 'src/common/types';
import { Speaking } from '../domain/speaking.domain';

export class SpeakingDto {
  @ApiProperty()
  readonly id: Uuid;

  @IsString()
  readonly number: string;

  @IsArray()
  @ArrayNotEmpty()
  @IsString({ each: true })
  readonly read: string[];

  @ApiProperty({ type: timeStamp })
  readonly createdAt: Date;

  @ApiProperty({ type: timeStamp })
  readonly updatedAt: Date;

  static fromDomain(speaking: Speaking): SpeakingDto {
    return {
      id: speaking.id,
      number: speaking.number,
      read: speaking.read,
      createdAt: speaking.createdAt,
      updatedAt: speaking.updatedAt,
    };
  }

  static fromDomains(domains: Speaking[]): SpeakingDto[] {
    return domains.map((d) => SpeakingDto.fromDomain(d));
  }
}
