import { SpeakingEntity } from "../entities/speaking.entity";

export class SpeakingCreate {
  number: string;

  read: string[];

  static toEntity(domain: SpeakingCreate): Partial<SpeakingEntity> {
    return {
      number: domain.number,
      read: domain.read,
    };
  }
}
