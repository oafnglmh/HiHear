import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';
import { FileUploadRequest } from '../domain/file-upload-request';

export class FileUploadRequestDto {
  @ApiProperty()
  @IsString()
  readonly fileName: string;

  @ApiProperty()
  @IsString()
  readonly folder: string;

  static toDomain(
    fileUploadRequestDto: FileUploadRequestDto,
  ): FileUploadRequest {
    return {
      fileName: fileUploadRequestDto.fileName,
      folder: fileUploadRequestDto.folder,
    };
  }
}
