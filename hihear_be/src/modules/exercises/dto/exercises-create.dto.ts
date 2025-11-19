import { ApiProperty } from '@nestjs/swagger';
import { ExerciseType } from 'src/utils/enums/exercise-type.enum';
import { ExercisesCreate } from '../domain/exercises-create.domain';
import { Nationality } from 'src/utils/enums/nationality.enum';
import { VocabularyCreateDto } from 'src/modules/exercise-vocabulary/dto/vocabulary-create.dto';
import {
  IsArray,
  IsEnum,
  IsInt,
  IsOptional,
  Min,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { GrammarCreateDto } from 'src/modules/exercise-gramma/dto/grammar-create.domain';
import { ListeningCreateDto } from 'src/modules/exercise-listening/dto/listening-create.dto';

export class ExercisesCreateDto {
  @ApiProperty({ enum: ExerciseType })
  @IsEnum(ExerciseType)
  type: ExerciseType;

  @ApiProperty()
  @IsInt()
  @Min(0)
  points: number;

  @ApiProperty({ enum: Nationality })
  @IsEnum(Nationality)
  national: Nationality;

  @ApiProperty({ type: () => [VocabularyCreateDto], required: false })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => VocabularyCreateDto)
  vocabularies?: VocabularyCreateDto[];

  @ApiProperty({ type: () => [GrammarCreateDto], required: false })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => GrammarCreateDto)
  grammars?: GrammarCreateDto[];

  @ApiProperty({ type: () => [ListeningCreateDto], required: false })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ListeningCreateDto)
  listenings?: ListeningCreateDto[];

  static toExerciseCreate(exercisesDto: ExercisesCreateDto): ExercisesCreate {
    return {
      type: exercisesDto.type,
      points: exercisesDto.points,
      national: exercisesDto.national,
      vocabularies: exercisesDto.vocabularies,
      grammars: exercisesDto.grammars,
    };
  }
}
