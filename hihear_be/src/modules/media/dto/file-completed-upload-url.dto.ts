import { FileType } from 'src/utils/enums/file-type.enum';
import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsOptional, IsString, IsUUID } from 'class-validator';
import { FileCompletedUploadUrl } from '../domain/file-completed-upload-url';
import type { Uuid } from 'src/common/types';

export class FileCompletedUploadUrlDto {
  @ApiProperty({
    description: 'ID của lesson mà file thuộc về',
    required: false,
  })
  @IsOptional()
  @IsUUID()
  readonly lessonId: Uuid | null;

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
      lessonId: fileCompletedUploadUrlDto.lessonId,
      fileType: fileCompletedUploadUrlDto.fileType,
      fileName: fileCompletedUploadUrlDto.fileName,
    };
  }
}
