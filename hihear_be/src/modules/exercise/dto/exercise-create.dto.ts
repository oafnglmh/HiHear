import {
  ApiProperty,
  ApiPropertyOptional,
  getSchemaPath,
} from '@nestjs/swagger';
import { ExerciseType } from 'src/utils/exercise-type.enum';
import { VocabularyContentDto } from './vocabulary-content.dto';
import { GrammarContentDto } from './grammar-content.dto';
import { ListeningContentDto } from './listening-content.dto';
import { SpeakingContentDto } from './speaking-content.dto';
import { LessionCreateDto } from 'src/modules/lession/dto/lession-create.dto';
import { ExerciseCreate } from '../domain/exercise-create.domain';
import { LessionDto } from 'src/modules/lession/dto/lession.dto';

export type ExerciseContentDto =
  | VocabularyContentDto
  | GrammarContentDto
  | ListeningContentDto
  | SpeakingContentDto;

export class ExerciseCreateDto {
  @ApiProperty({ type: () => LessionCreateDto })
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

  static toExerciseCreate(exerciseDto: ExerciseCreateDto): ExerciseCreate {
    return {
      lesson: LessionDto.fromDomain(exerciseDto.lesson),
      type: exerciseDto.type,
      content: exerciseDto.content,
      points: exerciseDto.points,
      aiFeedback: exerciseDto.aiFeedback,
    };
  }
}
