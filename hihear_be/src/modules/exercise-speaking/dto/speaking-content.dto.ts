import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString, IsOptional } from 'class-validator';

export class SpeakingContentDto {
  @ApiProperty({ description: 'câu phát âm' })
  @IsString()
  prompt: string;

  @ApiPropertyOptional({ description: '' })
  @IsOptional()
  @IsString()
  benchmarkAnswer?: string;
}
