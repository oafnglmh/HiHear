import { MediaEntity } from '../entities/media.entity';
import _ from 'lodash';

export class Media {
  readonly id: string;

  readonly lessonId: string | null;

  readonly listeningId: string | null;

  readonly fileType: string;

  readonly fileName: string;

  readonly fileUrl: string;

  readonly createdAt: Date;

  readonly updatedAt: Date;

  static fromEntity(mediaEntity: MediaEntity): Media {
    return {
      id: mediaEntity.id,
      lessonId: mediaEntity.lesson?.id ?? null,
      listeningId: mediaEntity.listening?.id ?? null,
      fileType: mediaEntity.fileType,
      fileName: mediaEntity.fileName,
      fileUrl: mediaEntity.fileUrl,
      createdAt: mediaEntity.createdAt,
      updatedAt: mediaEntity.updatedAt,
    };
  }

  static fromEntities(entities: MediaEntity[]): Media[] {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
    return _.map(entities, (e) => Media.fromEntity(e)) as Media[];
  }
}
