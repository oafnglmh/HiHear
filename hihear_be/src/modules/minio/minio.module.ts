import { Module } from '@nestjs/common';
import { MinioClientService } from './minio.service';
import { MinioAdapter } from './minio.adapter';

@Module({
  providers: [MinioClientService, MinioAdapter],
  exports: [MinioClientService],
})
export class MinioClientModule {}
