import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';
import { timeStamp } from 'console';
import type { Uuid } from 'src/common/types';
import { Grammar } from '../domain/grammar.domain';

export class GrammarDto {
  @ApiProperty()
  readonly id: Uuid;

  @ApiProperty({ description: 'Quy tắc ngữ pháp' })
  @IsString()
  readonly grammarRule: string;

  @ApiProperty({ description: 'Ví dụ minh họa' })
  @IsString()
  readonly example: string;

  @ApiProperty({ description: 'Ý nghĩa của quy tắc' })
  @IsString()
  readonly meaning: string;

  @ApiProperty({ type: timeStamp })
  readonly createdAt: Date;

  @ApiProperty({ type: timeStamp })
  readonly updatedAt: Date;

  static fromDomain(grammar: Grammar): GrammarDto {
    return {
      id: grammar.id,
      grammarRule: grammar.grammarRule,
      example: grammar.example,
      meaning: grammar.meaning,
      createdAt: grammar.createdAt,
      updatedAt: grammar.updatedAt,
    };
  }

  static fromDomains(domains: Grammar[]): GrammarDto[] {
    return domains.map((d) => GrammarDto.fromDomain(d));
  }
}
