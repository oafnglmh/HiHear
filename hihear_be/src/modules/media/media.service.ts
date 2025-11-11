import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { MediaEntity } from './entities/media.entity';
import { MinioClientService } from '../minio/minio.service';
import { Media } from './domain/media';
import { FileUploadRequest } from './domain/file-upload-request';
import { FileUploadResponse } from './domain/file-upload-response';
import { FileCompletedUploadUrl } from './domain/file-completed-upload-url';
import { Uuid } from 'src/common/types';
import { LessonEntity } from '../lesson/entities/lesson.entity';

@Injectable()
export class MediaService {
  constructor(
    @InjectRepository(MediaEntity)
    private readonly mediaRepository: Repository<MediaEntity>,

    private readonly minioService: MinioClientService,
  ) {}

  async requestUploadUrl(
    fileUploadRequest: FileUploadRequest,
  ): Promise<FileUploadResponse> {
    Logger.log(`Requesting upload URL for file: ${fileUploadRequest.fileName}`);

    const { uploadUrl, fileName } =
      await this.minioService.createPresignedUploadUrl(
        fileUploadRequest.fileName,
        fileUploadRequest.folder,
      );

    return { uploadUrl, fileName };
  }

  async completeUpload(
    fileCompletedUploadUrl: FileCompletedUploadUrl,
  ): Promise<Media> {
    Logger.log(
      `Completing upload for file: ${fileCompletedUploadUrl.fileName}`,
    );

    const exists = await this.minioService.fileExists(
      fileCompletedUploadUrl.fileName,
    );

    if (!exists) {
      throw new Error('Uploaded file does not exist');
    }

    const fileUrl = this.minioService.getPublicFileUrl(
      fileCompletedUploadUrl.fileName,
    );

    return Media.fromEntity(
      await this.mediaRepository.save(
        this.mediaRepository.create({
          ...FileCompletedUploadUrl.toEntity(fileCompletedUploadUrl),
          fileUrl,
        }),
      ),
    );
  }

  async assignMediaToLesson(
    mediaId: Uuid,
    lesson: LessonEntity,
  ): Promise<Media> {
    const media = await this.mediaRepository.findOneBy({ id: mediaId });
    if (!media) throw new NotFoundException(`Media ${mediaId} not found`);

    media.lesson = lesson;

    return Media.fromEntity(await this.mediaRepository.save(media));
  }
}
