import { MediaType } from 'src/utils/media.enum';
import { MediaCreate } from '../domain/media-create.domain';
import { LessionDto } from 'src/modules/lession/dto/lession.dto';

export class MediaCreateDto {
  lession: LessionDto;

  url: string;

  type: MediaType;

  caption?: string;

  static toMediaCreate(mediaCreateDto: MediaCreateDto): MediaCreate {
    return {
      lession: LessionDto.fromDomain(mediaCreateDto.lession),
      url: mediaCreateDto.url,
      type: mediaCreateDto.type,
      caption: mediaCreateDto.caption,
    };
  }
}
