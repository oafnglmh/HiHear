import { Body, Controller, Post } from '@nestjs/common';
import { MediaService } from './media.service';
import { MediaDto } from './dto/media.dto';
import { FileUploadRequestDto } from './dto/file-upload-request.dto';
import { FileUploadResponseDto } from './dto/file-upload-response.dto';
import { FileCompletedUploadUrlDto } from './dto/file-completed-upload-url.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('medias')
@Controller('medias')
export class MediaController {
  constructor(private readonly mediaService: MediaService) {}

  @Post('presigned-upload')
  async requestUploadUrl(
    @Body() fileUploadRequestDto: FileUploadRequestDto,
  ): Promise<FileUploadResponseDto> {
    return FileUploadResponseDto.fromDomain(
      await this.mediaService.requestUploadUrl(
        FileUploadRequestDto.toDomain(fileUploadRequestDto),
      ),
    );
  }

  @Post('completed-upload')
  async completedUpload(
    @Body() fileCompletedUploadUrlDto: FileCompletedUploadUrlDto,
  ): Promise<MediaDto> {
    return MediaDto.fromDomain(
      await this.mediaService.completeUpload(
        FileCompletedUploadUrlDto.toDomain(fileCompletedUploadUrlDto),
      ),
    );
  }
}
