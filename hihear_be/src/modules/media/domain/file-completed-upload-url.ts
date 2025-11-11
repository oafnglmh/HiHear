import { FileType } from 'src/utils/enums/file-type.enum';
import { MediaEntity } from '../entities/media.entity';
import { Uuid } from 'src/common/types';

export class FileCompletedUploadUrl {
  readonly lessonId: Uuid | null;

  readonly fileType: FileType;

  readonly fileName: string;

  static toEntity(
    fileCompletedUploadUrl: FileCompletedUploadUrl,
  ): Partial<MediaEntity> {
    return {
      fileType: fileCompletedUploadUrl.fileType,
      fileName: fileCompletedUploadUrl.fileName,
      lesson: null,
    };
  }
}
