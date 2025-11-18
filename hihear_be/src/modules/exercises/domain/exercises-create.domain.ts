import { ExerciseType } from 'src/utils/enums/exercise-type.enum';
import { ExercisesCreateDto } from '../dto/exercises-create.dto';
import { Nationality } from 'src/utils/enums/nationality.enum';
import { VocabularyCreate } from 'src/modules/exercise-vocabulary/domain/vocabulary-create.domain';
import { GrammarCreate } from 'src/modules/exercise-gramma/domain/grammar-create.domain';
import { ListeningCreate } from 'src/modules/exercise-listening/domain/listening-create.domain';

export class ExercisesCreate {
  type: ExerciseType;

  points: number;

  vocabularies?: VocabularyCreate[];

  grammars?: GrammarCreate[];

  listenings?: ListeningCreate[];

  national: Nationality;

  static toEntity(exercisesCreate: ExercisesCreate): ExercisesCreateDto {
    return {
      type: exercisesCreate.type,
      points: exercisesCreate.points,
      national: exercisesCreate.national,
    };
  }
}
