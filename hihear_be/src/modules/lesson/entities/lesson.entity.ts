import { AbstractEntity } from 'src/common/abstract.entity';
import { MediaEntity } from 'src/modules/media/entities/media.entity';
import { UserEntity } from 'src/modules/users/entities/user.entity';
import { Column, Entity, JoinColumn, ManyToOne, OneToMany } from 'typeorm';

@Entity('lessons')
export class LessonEntity extends AbstractEntity {
  @Column()
  title: string;

  @Column({ type: 'text', nullable: true })
  description: string;

  @Column({ length: 100, nullable: true })
  category: string;

  @Column({ length: 10, nullable: true })
  level: string;

  @Column({ type: 'int', default: 0 })
  durationSeconds: number;

  @Column({ type: 'int', default: 0 })
  xpReward: number;

  @ManyToOne(() => LessonEntity, { nullable: true, onDelete: 'SET NULL' })
  prerequisiteLesson: LessonEntity;

  @ManyToOne(() => UserEntity, { onDelete: 'CASCADE', onUpdate: 'CASCADE' })
  @JoinColumn()
  user: UserEntity;

  @OneToMany(() => MediaEntity, (media) => media.lesson, { cascade: true })
  media: MediaEntity[];
}
