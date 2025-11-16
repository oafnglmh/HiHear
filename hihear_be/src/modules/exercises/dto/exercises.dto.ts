import { ApiProperty } from '@nestjs/swagger';
import { ExerciseType } from 'src/utils/enums/exercise-type.enum';
import { Exercises } from '../domain/exercises.domain';
import type { Uuid } from 'src/common/types';
import { timeStamp } from 'console';
import { Nationality } from 'src/utils/enums/nationality.enum';
import { VocabularyDto } from 'src/modules/exercise-vocabulary/dto/vocabulary.dto';

export class ExercisesDto {
  @ApiProperty()
  readonly id: Uuid;

  @ApiProperty()
  readonly lessonId: string | null;

  @ApiProperty({ enum: ExerciseType })
  readonly type: ExerciseType;

  @ApiProperty()
  readonly points: number;

  @ApiProperty({ enum: Nationality })
  readonly national: Nationality;

  @ApiProperty({ type: () => [VocabularyDto], required: false })
  vocabularies?: VocabularyDto[];

  @ApiProperty({ type: timeStamp })
  readonly createdAt: Date;

  @ApiProperty({ type: timeStamp })
  readonly updatedAt: Date;

  static fromDomain(exercise: Exercises): ExercisesDto {
    return {
      id: exercise.id,
      lessonId: exercise.lessonId ?? null,
      type: exercise.type,
      points: exercise.points,
      national: exercise.national,
      vocabularies: exercise.vocabularies,
      createdAt: exercise.createdAt,
      updatedAt: exercise.updatedAt,
    };
  }

  static fromDomains(domains: Exercises[]): ExercisesDto[] {
    return domains.map((d) => ExercisesDto.fromDomain(d));
  }
}
