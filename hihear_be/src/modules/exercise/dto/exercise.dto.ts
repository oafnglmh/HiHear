import {
  ApiProperty,
  ApiPropertyOptional,
  getSchemaPath,
} from '@nestjs/swagger';
import { ExerciseType } from 'src/utils/exercise-type.enum';
import { Exercise } from '../domain/exercise.domain';
import { VocabularyContentDto } from './vocabulary-content.dto';
import { GrammarContentDto } from './grammar-content.dto';
import { ListeningContentDto } from './listening-content.dto';
import { SpeakingContentDto } from './speaking-content.dto';
import { LessionDto } from 'src/modules/lession/dto/lession.dto';
import type { Uuid } from 'src/common/types';
import { timeStamp } from 'console';

export type ExerciseContentDto =
  | VocabularyContentDto
  | GrammarContentDto
  | ListeningContentDto
  | SpeakingContentDto;

export class ExerciseDto {
  @ApiProperty()
  id: Uuid;

  @ApiProperty({ type: () => LessionDto })
  lesson: LessionDto;

  @ApiProperty({ enum: ExerciseType })
  type: ExerciseType;

  @ApiProperty({
    oneOf: [
      { $ref: getSchemaPath(VocabularyContentDto) },
      { $ref: getSchemaPath(GrammarContentDto) },
      { $ref: getSchemaPath(ListeningContentDto) },
      { $ref: getSchemaPath(SpeakingContentDto) },
    ],
  })
  content: ExerciseContentDto;

  @ApiProperty()
  points: number;

  @ApiPropertyOptional()
  aiFeedback: string;

  @ApiProperty({ type: timeStamp })
  createdAt: Date;

  @ApiProperty({ type: timeStamp })
  updatedAt: Date;

  static fromDomain(exercise: Exercise): ExerciseDto {
    return {
      id: exercise.id,
      lesson: LessionDto.fromDomain(exercise.lesson),
      type: exercise.type,
      content: exercise.content as ExerciseContentDto,
      points: exercise.points,
      aiFeedback: exercise.aiFeedback,
      createdAt: exercise.createdAt,
      updatedAt: exercise.updatedAt,
    };
  }

  static fromDomains(domains: Exercise[]): ExerciseDto[] {
    return domains.map((d) => ExerciseDto.fromDomain(d));
  }
}
