import { MediaType } from 'src/utils/media.enum';
import { Media } from '../domain/media.domain';
import { LessionDto } from 'src/modules/lession/dto/lession.dto';

export class MediaDto {
  id: string;

  lesson: LessionDto;

  url: string;

  type: MediaType;

  caption?: string;

  static fromDomain(media: Media): MediaDto {
    return {
      id: media.id,
      lesson: LessionDto.fromDomain(media.lession),
      url: media.url,
      type: media.type,
      caption: media.caption,
    };
  }

  static fromDomains(media: Media[]): MediaDto[] {
    return media.map((domain) => MediaDto.fromDomain(domain));
  }
}
