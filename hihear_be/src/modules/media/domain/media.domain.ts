/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import { MediaType } from 'src/utils/media.enum';
import { MediaEntity } from '../entities/media.entity';
import _ from 'lodash';
import { Lession } from 'src/modules/lession/domain/lession.domain';

export class Media {
  id: string;

  lession: Lession;

  url: string;

  type: MediaType;

  caption?: string;

  createdAt: Date;

  updatedAt: Date;

  static fromEntity(mediaEntity: MediaEntity): Media {
    return {
      id: mediaEntity.id,
      lession: Lession.fromEntity(mediaEntity.lesson),
      type: mediaEntity.type,
      url: mediaEntity.url,
      caption: mediaEntity.caption,
      createdAt: mediaEntity.createdAt,
      updatedAt: mediaEntity.updatedAt,
    };
  }

  static fromEntities(mediaEntities: MediaEntity[]): Media[] {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-call
    return _.map(mediaEntities, (e) => Media.fromEntity(e)) as Media[];
  }
}
