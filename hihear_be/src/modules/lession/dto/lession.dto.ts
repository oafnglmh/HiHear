import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString } from 'class-validator';
import { Lession } from '../domain/lession.domain';
import type { Uuid } from 'src/common/types';
import { timeStamp } from 'console';

export class LessionDto {
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

  @ApiPropertyOptional({ type: () => Lession, isArray: true })
  prerequisiteLesson: Lession | null;

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
      xpReward: lession.xpReward,
      createdAt: lession.createdAt,
      updatedAt: lession.updatedAt,
    };
  }

  static fromDomains(lessions: Lession[]): LessionDto[] {
    return lessions.map((lession) => this.fromDomain(lession));
  }
}
