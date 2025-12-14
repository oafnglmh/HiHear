import { LessonVideoEntity } from '../entities/lesson-video.entity';

export class LessonVideo {
  id: string;
  fileName: string;
  fileSize: string;
  videoUrl: string;
  cloudinaryId: string;
  duration: number;
  transcriptions: {
    vi: string;
    en: string;
    ko: string;
    start: number;
    end: number;
  }[];

  static fromEntity(entity: LessonVideoEntity): LessonVideo {
    return {
      id: entity.id,
      fileName: entity.fileName,
      fileSize: entity.fileSize,
      videoUrl: entity.videoUrl,
      cloudinaryId: entity.cloudinaryId,
      duration: entity.duration,
      transcriptions: entity.transcriptions,
    };
  }
}
