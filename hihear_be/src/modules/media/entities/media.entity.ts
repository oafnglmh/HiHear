import { Column, Entity, ManyToOne } from 'typeorm';
import { AbstractEntity } from 'src/common/abstract.entity';
import { LessonEntity } from 'src/modules/lesson/entities/lesson.entity';
import { FileType } from 'src/utils/enums/file-type.enum';
import { ListeningEntity } from 'src/modules/exercise-listening/entities/listening.entity';

@Entity('medias')
export class MediaEntity extends AbstractEntity {
  @ManyToOne(() => LessonEntity, (lesson) => lesson.media, {
    onDelete: 'SET NULL',
    nullable: true,
  })
  lesson: LessonEntity | null;

  @Column()
  readonly fileName: string;

  @Column()
  readonly fileUrl: string;

  @Column({ type: 'enum', enum: FileType })
  readonly fileType: FileType;

  @ManyToOne(() => ListeningEntity, (listening) => listening.media, {
    onDelete: 'SET NULL',
    nullable: true,
  })
  listening: ListeningEntity | null;
}
