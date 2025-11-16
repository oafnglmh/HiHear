import { FileType } from 'src/utils/enums/file-type.enum';
import { MediaEntity } from '../entities/media.entity';

export class FileCompletedUploadUrl {
  readonly fileType: FileType;

  readonly fileName: string;

  static toEntity(
    fileCompletedUploadUrl: FileCompletedUploadUrl,
  ): Partial<MediaEntity> {
    return {
      fileType: fileCompletedUploadUrl.fileType,
      fileName: fileCompletedUploadUrl.fileName,
    };
  }
}
