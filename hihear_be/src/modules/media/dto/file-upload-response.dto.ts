import { ApiProperty } from '@nestjs/swagger';
import { FileUploadResponse } from '../domain/file-upload-response';
import { IsString } from 'class-validator';

export class FileUploadResponseDto {
  @ApiProperty()
  @IsString()
  readonly uploadUrl: string;

  @ApiProperty()
  @IsString()
  readonly fileName: string;

  static fromDomain(fileUploadResponse: FileUploadResponse): FileUploadResponseDto {
    return {
      uploadUrl: fileUploadResponse.uploadUrl,
      fileName: fileUploadResponse.fileName,
    };
  }
}
