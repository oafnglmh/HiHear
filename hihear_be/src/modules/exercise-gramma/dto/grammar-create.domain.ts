import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';
import { GrammarCreate } from '../domain/grammar-create.domain';

export class GrammarCreateDto {
  @ApiProperty({ description: 'Quy tắc ngữ pháp' })
  @IsString()
  readonly grammarRule: string;

  @ApiProperty({ description: 'Ví dụ minh họa' })
  @IsString()
  readonly example: string;

  @ApiProperty({ description: 'Ý nghĩa của quy tắc' })
  @IsString()
  readonly meaning: string;

  static toGrammarCreate(grammarDto: GrammarCreateDto): GrammarCreate {
    return {
      grammarRule: grammarDto.grammarRule,
      example: grammarDto.example,
      meaning: grammarDto.meaning,
    };
  }
}
