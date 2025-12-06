import { AbstractEntity } from 'src/common/abstract.entity';
import { Column, Entity, ManyToOne, JoinColumn, Unique, Index } from 'typeorm';
import { UserEntity } from 'src/modules/users/entities/user.entity';
import { LessonEntity } from 'src/modules/lesson/entities/lesson.entity';

@Entity('user_lesson_progress')
@Unique('UQ_user_lesson', ['user_id', 'lesson_id'])
export class UserLessonProgressEntity extends AbstractEntity {

  @Column({ type: 'uuid' })
  @Index('IDX_user_lesson_progress_user_id')
  user_id: string;

  @Column({ type: 'uuid' })
  @Index('IDX_user_lesson_progress_lesson_id')
  lesson_id: string;

  @Column({ default: false })
  completed: boolean;

  @Column({ type: 'timestamp', nullable: true })
  completed_at: Date | null;

  @ManyToOne(() => UserEntity, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: UserEntity;

  @ManyToOne(() => LessonEntity, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'lesson_id' })
  lesson: LessonEntity;
}
