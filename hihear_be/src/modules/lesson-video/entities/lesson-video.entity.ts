import { Column, Entity, JoinColumn, ManyToOne, OneToOne } from 'typeorm';
import { AbstractEntity } from 'src/common/abstract.entity';
import { LessonEntity } from '../../lesson/entities/lesson.entity';

@Entity('lesson_videos')
export class LessonVideoEntity extends AbstractEntity {
  @Column()
  fileName: string;

  @Column()
  fileSize: string;

  @Column()
  videoUrl: string;

  @Column()
  cloudinaryId: string;

  @Column({ type: 'float' })
  duration: number;

  @Column({ type: 'jsonb' })
  transcriptions: {
    vi: string;
    en: string;
    ko: string;
    start: number;
    end: number;
  }[];
}
