import { Uuid } from 'src/common/types';
import { ListeningCreateDto } from '../dto/listening-create.dto';
export class ListeningCreate {
  transcript?: string | null;

  mediaId: Uuid;

  choices: string[];

  correctAnswer: string;

  static toEntity(
    listeningCreate: ListeningCreate,
  ): Partial<ListeningCreateDto> {
    return {
      transcript: listeningCreate.transcript ?? null,
      choices: listeningCreate.choices,
      correctAnswer: listeningCreate.correctAnswer,
    };
  }
}
