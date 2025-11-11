import { Injectable, Logger } from '@nestjs/common';
import { MinioAdapter } from './minio.adapter';
import { FilePresignedUploadResponse } from './domain/file-presigned-upload-response';

@Injectable()
export class MinioClientService {
  constructor(private readonly minioAdapter: MinioAdapter) {}

  async createPresignedUploadUrl(
    originalFilename: string,
    folder: string,
  ): Promise<FilePresignedUploadResponse> {
    try {
      const fileExtension = originalFilename.split('.').pop();

      const fileName = `${folder}/${crypto.randomUUID()}.${fileExtension}`;

      const uploadUrl =
        await this.minioAdapter.createPresignedUploadUrl(fileName);

      Logger.log(`Create presigned URL: ${fileName}`);

      return { uploadUrl, fileName };
    } catch (err) {
      Logger.error('Error creating presigned URL', err);
      throw new Error('Unable to create upload URL');
    }
  }

  async fileExists(fileName: string): Promise<boolean> {
    return this.minioAdapter.fileExists(fileName);
  }

  getPublicFileUrl(objectName: string): string {
    return this.minioAdapter.getPublicFileUrl(objectName);
  }
}
