import { AbstractEntity } from 'src/common/abstract.entity';
import { ExercisesEntity } from 'src/modules/exercises/entities/exercises.entity';
import { MediaEntity } from 'src/modules/media/entities/media.entity';
import { UserEntity } from 'src/modules/users/entities/user.entity';
import { Column, Entity, JoinColumn, ManyToOne, OneToMany } from 'typeorm';
import { LessonCategory } from 'src/utils/enums/lesson-category.enum';

@Entity('lessons')
export class LessonEntity extends AbstractEntity {
  @Column()
  title: string;

  @Column({ type: 'text', nullable: true })
  description: string;

  @Column({
    type: 'enum',
    enum: LessonCategory,
    default: LessonCategory.VOCABULARY,
  })
  category: LessonCategory;

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

  @OneToMany(() => ExercisesEntity, (exercise) => exercise.lesson, {
    cascade: ['insert', 'update'],
    eager: true,
  })
  exercises: ExercisesEntity[];
}
