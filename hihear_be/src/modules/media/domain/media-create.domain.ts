import { MediaType } from 'src/utils/media.enum';
import { MediaCreateDto } from '../dto/media-create.dto';
import { Lession } from 'src/modules/lession/domain/lession.domain';

export class MediaCreate {
  lession: Lession;

  url: string;

  type: MediaType;

  caption?: string;

  static toEntity(mediaCreate: MediaCreate): Partial<MediaCreateDto> {
    return {
      lession: Lession.fromEntity(mediaCreate.lession),
      type: mediaCreate.type,
      url: mediaCreate.url,
      caption: mediaCreate.caption,
    };
  }
}
