import { ExerciseType } from 'src/utils/exercise-type.enum';
import { VocabularyContent } from './vocabulary-content.domain';
import { GrammarContent } from './gramma-content.domain';
import { ListeningContent } from './listening-content.domain';
import { SpeakingContent } from './speaking-content.domain';
import { ExerciseCreateDto } from '../dto/exercise-create.dto';
import { Lession } from 'src/modules/lession/domain/lession.domain';

export class ExerciseCreate {
  lesson: Lession;

  type: ExerciseType;

  content: VocabularyContent | GrammarContent | ListeningContent | SpeakingContent;

  points: number;

  aiFeedback: string;

  static toEntity(exerciseCreate: ExerciseCreate): Partial<ExerciseCreateDto> {
    return {
      lesson: Lession.fromEntity(exerciseCreate.lesson),
      type: exerciseCreate.type,
      content: exerciseCreate.content,
      points: exerciseCreate.points,
      aiFeedback: exerciseCreate.aiFeedback,
    };
  }
}
