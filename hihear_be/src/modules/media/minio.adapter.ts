import { Injectable, Logger } from '@nestjs/common';
import { Client } from 'minio';
import { ApiConfigService } from 'src/shared/services/api-config.service';

const EXPIRY_SECONDS = 30 * 60;

@Injectable()
export class MinioAdapter {
  private readonly client: Client;
  private readonly bucketName: string;

  constructor(private readonly configService: ApiConfigService) {
    const minioConfig = this.configService.minioConfig;

    Logger.log('Initializing MinIO Client...');
    this.client = new Client({
      endPoint: minioConfig.endPoint,
      port: minioConfig.port,
      useSSL: minioConfig.useSSL,
      accessKey: minioConfig.accessKey,
      secretKey: minioConfig.secretKey,
    });
    Logger.log('MinIO Client initialized successfully.', this.bucketName);

    this.bucketName = configService.minioConfig.bucketName;
  }

  async createPresignedUploadUrl(objectName: string): Promise<string> {
    return await this.client.presignedPutObject(
      this.bucketName,
      objectName,
      EXPIRY_SECONDS,
    );
  }

  async fileExists(fileName: string): Promise<boolean> {
    try {
      await this.client.statObject(this.bucketName, fileName);

      return true;
    } catch (err) {
      if (err.code === 'NotFound') {
        return false;
      }

      Logger.error('Error checking file existence', err);
      throw err;
    }
  }

  getPublicFileUrl(objectName: string): string {
    const url = this.configService.minioConfig.url;

    return `${url}/${objectName}`;
  }
}
