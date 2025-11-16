import { FileType } from 'src/utils/enums/file-type.enum';
import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsString } from 'class-validator';
import { FileCompletedUploadUrl } from '../domain/file-completed-upload-url';

export class FileCompletedUploadUrlDto {
  @ApiProperty()
  @IsEnum(FileType)
  readonly fileType: FileType;

  @ApiProperty()
  @IsString()
  readonly fileName: string;

  static toDomain(
    fileCompletedUploadUrlDto: FileCompletedUploadUrlDto,
  ): FileCompletedUploadUrl {
    return {
      fileType: fileCompletedUploadUrlDto.fileType,
      fileName: fileCompletedUploadUrlDto.fileName,
    };
  }
}
