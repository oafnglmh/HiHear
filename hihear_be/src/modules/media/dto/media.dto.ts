import { ApiProperty } from '@nestjs/swagger';
import { Media } from '../domain/media';

export class MediaDto {
  @ApiProperty()
  readonly id: string;

  @ApiProperty()
  readonly lessonId: string | null;

  @ApiProperty()
  readonly fileType: string;

  @ApiProperty()
  readonly fileName: string;

  @ApiProperty()
  readonly fileUrl: string;

  @ApiProperty()
  readonly createdAt: Date;

  @ApiProperty()
  readonly updatedAt: Date;

  static fromDomain(media: Media): MediaDto {
    return {
      id: media.id,
      lessonId: media.lessonId ?? null,
      fileType: media.fileType,
      fileName: media.fileName,
      fileUrl: media.fileUrl,
      createdAt: media.createdAt,
      updatedAt: media.updatedAt,
    };
  }
}
