import { AbstractEntity } from 'src/common/abstract.entity';
import { ExerciseEntity } from 'src/modules/exercise/entities/exercise.entity';
import { MediaEntity } from 'src/modules/media/entities/media.entity';
import { UserEntity } from 'src/modules/users/entities/user.entity';
import { LessonCategory } from 'src/utils/lesson-category.enum';
import { Column, Entity, JoinColumn, ManyToOne, OneToMany } from 'typeorm';

@Entity('lession')
export class LessionEntity extends AbstractEntity {
  @Column()
  title: string;

  @Column({ type: 'text', nullable: true })
  description: string;

  @Column({ type: 'enum', enum: LessonCategory, nullable: true })
  category: LessonCategory;

  @Column({ length: 10, nullable: true })
  level: string;

  @Column({ type: 'int', default: 0 })
  durationSeconds: number;

  @Column({ type: 'int', default: 0 })
  xpReward: number;

  @ManyToOne(() => LessionEntity, { nullable: true, onDelete: 'SET NULL' })
  prerequisiteLesson: LessionEntity;

  @ManyToOne(() => UserEntity, { onDelete: 'CASCADE', onUpdate: 'CASCADE' })
  @JoinColumn()
  user: UserEntity;

  @OneToMany(() => MediaEntity, (media) => media.lesson, { cascade: true })
  media: MediaEntity[];

  @OneToMany(() => ExerciseEntity, (exercise) => exercise.lesson, {
    cascade: true,
  })
  exercises: ExerciseEntity[];
}
