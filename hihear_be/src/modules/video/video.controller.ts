import { Controller, Post, UploadedFile, UseInterceptors } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { join } from 'path';
import { VideoService } from './video.service';
import { diskStorage } from 'multer';

@Controller('video')
export class VideoController {
  constructor(private readonly videoService: VideoService) {}

  @Post('transcribe')
  @UseInterceptors(FileInterceptor('file', {
    storage: diskStorage({
      destination: './uploads',
      filename: (req, file, cb) => cb(null, `${Date.now()}-${file.originalname}`)
    })
  }))
  async transcribe(@UploadedFile() file: Express.Multer.File) {
    return this.videoService.transcribe(file.path);
  }
}
