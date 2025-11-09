import { Column, Entity, ManyToOne } from 'typeorm';
import { AbstractEntity } from 'src/common/abstract.entity';
import { LessionEntity } from 'src/modules/lession/entities/lession.entity';
import { MediaType } from 'src/utils/media.enum';

@Entity('media')
export class MediaEntity extends AbstractEntity {
  @ManyToOne(() => LessionEntity, (lesson) => lesson.media, {
    onDelete: 'CASCADE',
  })
  lesson: LessionEntity;

  @Column({ type: 'varchar', length: 255 })
  url: string;

  @Column({ type: 'enum', enum: MediaType })
  type: MediaType;

  @Column({ type: 'text', nullable: true })
  caption?: string;
}
